import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/api/api_client.dart';
import '../../../core/constants/env.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../shared/providers/in_app_notification_provider.dart';
import '../../brands/providers/brand_notifier.dart';
import '../../checkout/providers/active_order_notifier.dart';
import '../../qr_session/providers/qr_session_notifier.dart';
import '../domain/fulfillment_status.dart';
import '../domain/order_tracking_state.dart';

part 'order_tracking_notifier.g.dart';

String _wsBase() => kApiBaseUrl
    .replaceFirst('https://', 'wss://')
    .replaceFirst('http://', 'ws://');

/// Single WebSocket + polling owner for a tracked order.
///
/// Handles both `fulfillment.status_changed` and `payment.status_changed`
/// on `ws/order/{orderId}/` so the Payment screen and Tracking screen share
/// ONE connection per order (CLAUDE.md §7.1).
///
/// Reconnection uses exponential backoff (1 s → 2 s → 4 s … capped at 30 s).
/// [OrderTrackingState.isReconnecting] drives an amber UI banner (CLAUDE.md §7.2).
@riverpod
class OrderTrackingNotifier extends _$OrderTrackingNotifier {
  WebSocketChannel? _ws;
  Timer? _pollTimer;
  Timer? _reconnectTimer;
  bool _disposed = false;
  int _backoffSeconds = 1;

  @override
  Future<OrderTrackingState> build(String orderId) async {
    ref.onDispose(() {
      _disposed = true;
      _cleanup();
    });

    final initial = await _fetchOrderState(orderId);

    if (!initial.fulfillmentStatus.isTerminal) {
      unawaited(_connectWebSocket(orderId));
      _startPolling(orderId);
    }

    return initial;
  }

  // ---------------------------------------------------------------------------
  // Initial + polling fetch
  // ---------------------------------------------------------------------------

  Future<OrderTrackingState> _fetchOrderState(String orderId) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get<dynamic>('/api/v1/orders/$orderId/');
    final body = res.data as Map<String, dynamic>;
    final data = body['data'] as Map<String, dynamic>;

    final rawItems = data['items'] as List<dynamic>? ?? [];
    final items = rawItems
        .map((e) => _parseItem(e as Map<String, dynamic>))
        .toList();

    final status =
        FulfillmentStatus.fromString(data['fulfillment_status'] as String?) ??
            FulfillmentStatus.received;

    final paymentSettled = data['payment_status'] == 'SETTLED';

    return OrderTrackingState(
      fulfillmentStatus: status,
      paymentSettled: paymentSettled,
      orderItems: items,
      orderNumber: data['order_number'] as String?,
      subtotal: data['subtotal'] as String?,
      taxAmount: data['tax_amount'] as String?,
      grandTotal: data['grand_total'] as String?,
      orderNotes: data['notes'] as String?,
    );
  }

  TrackingOrderItem _parseItem(Map<String, dynamic> json) {
    final notes = json['item_notes'] as String?;
    return TrackingOrderItem(
      productName: (json['product_name'] as String?) ?? 'Produk',
      quantity: (json['quantity'] as int?) ?? 1,
      unitPrice: (json['unit_price'] as String?) ?? '0',
      lineTotal: (json['line_total'] as String?) ?? '0',
      itemNotes: (notes == null || notes.isEmpty) ? null : notes,
      imageUrl: (json['product_image'] ?? json['image_url']) as String?,
    );
  }

  void _startPolling(String orderId) {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      if (_disposed) return;
      try {
        final dio = ref.read(dioProvider);
        final res = await dio.get<dynamic>(
          '/api/v1/payments/$orderId/status/',
        );
        final body = res.data as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;

        final paymentStatus = data['payment_status'] as String?;
        if (paymentStatus == 'SETTLED') _onPaymentSettled(orderId);

        final statusStr = data['fulfillment_status'] as String?;
        final status = FulfillmentStatus.fromString(statusStr);
        if (status != null) _applyFulfillmentStatus(status, orderId);
      } catch (_) {}
    });
  }

  // ---------------------------------------------------------------------------
  // WebSocket
  // ---------------------------------------------------------------------------

  Future<void> _connectWebSocket(String orderId) async {
    if (_disposed) return;
    try {
      final token =
          await ref.read(secureStorageServiceProvider).getAccessToken();
      if (token == null || _disposed) return;

      final uri =
          Uri.parse('${_wsBase()}/ws/order/$orderId/?token=$token');
      _ws = WebSocketChannel.connect(uri);

      // Optimistically mark as connected; onDone/onError will flip back.
      _updateReconnecting(false);
      _backoffSeconds = 1;

      _ws!.stream.listen(
        (raw) {
          try {
            _handleMessage(raw as String, orderId);
          } catch (_) {}
        },
        onDone: () => _onWsDisconnected(orderId),
        onError: (_) => _onWsDisconnected(orderId),
        cancelOnError: false,
      );
    } catch (_) {
      _onWsDisconnected(orderId);
    }
  }

  void _onWsDisconnected(String orderId) {
    if (_disposed) return;
    final current = state.value;
    if (current != null && current.fulfillmentStatus.isTerminal) return;

    _updateReconnecting(true);
    _scheduleReconnect(orderId);
  }

  void _scheduleReconnect(String orderId) {
    if (_disposed) return;
    _reconnectTimer?.cancel();
    final delay = _backoffSeconds;
    _backoffSeconds = (_backoffSeconds * 2).clamp(1, 30);
    _reconnectTimer = Timer(Duration(seconds: delay), () {
      _connectWebSocket(orderId);
    });
  }

  // ---------------------------------------------------------------------------
  // Message handling
  // ---------------------------------------------------------------------------

  void _handleMessage(String raw, String orderId) {
    final msg = jsonDecode(raw) as Map<String, dynamic>;
    final event = msg['event'] as String?;
    final data = msg['data'] as Map<String, dynamic>?;

    switch (event) {
      case 'fulfillment.status_changed':
        final status = FulfillmentStatus.fromString(
          data?['fulfillment_status'] as String?,
        );
        if (status != null) _applyFulfillmentStatus(status, orderId);

      case 'payment.status_changed':
        if (data?['payment_status'] == 'SETTLED') {
          _onPaymentSettled(orderId);
        }
    }
  }

  // ---------------------------------------------------------------------------
  // State mutations
  // ---------------------------------------------------------------------------

  void _applyFulfillmentStatus(FulfillmentStatus status, String orderId) {
    if (_disposed) return;
    final current = state.value;
    if (current == null) return;
    // Don't regress the status.
    if (status.stepIndex >= 0 &&
        current.fulfillmentStatus.stepIndex > status.stepIndex) {
      return;
    }

    state = AsyncData(current.copyWith(fulfillmentStatus: status));

    _maybefireStatusNotification(status);

    if (status.isTerminal) _cleanup();
  }

  void _onPaymentSettled(String orderId) {
    if (_disposed) return;
    final current = state.value;
    if (current == null || current.paymentSettled) return;

    // Clear active table session so home shows "Scan QR" CTA (CLAUDE.md §4.3).
    ref.read(qrSessionNotifierProvider.notifier).clearSession();

    state = AsyncData(current.copyWith(paymentSettled: true));

    _fireNotification(
      title: 'Pembayaran Berhasil!',
      body: 'Pesananmu sedang disiapkan.',
    );
  }

  // ---------------------------------------------------------------------------
  // In-app notification helpers
  // ---------------------------------------------------------------------------

  /// Maps [FulfillmentStatus] values that warrant a push to a notification.
  /// [received] is skipped — the order-confirm screen already shows confirmation.
  void _maybefireStatusNotification(FulfillmentStatus status) {
    switch (status) {
      case FulfillmentStatus.inProgress:
        _fireNotification(
          title: 'Sedang Dimasak',
          body: 'Chef sedang menyiapkan pesananmu.',
        );
      case FulfillmentStatus.ready:
        _fireNotification(
          title: 'Pesanan Siap!',
          body: 'Pesananmu siap untuk disajikan.',
        );
      case FulfillmentStatus.served:
        _fireNotification(
          title: 'Selamat Menikmati!',
          body: 'Pesananmu telah tersaji di mejamu.',
        );
      case FulfillmentStatus.completed:
        _fireNotification(
          title: 'Pesanan Selesai',
          body: 'Terima kasih sudah memesan!',
        );
      default:
        break;
    }
  }

  void _fireNotification({required String title, required String body}) {
    if (_disposed) return;

    final session = ref.read(qrSessionNotifierProvider).valueOrNull;
    final brandName = session?.brandName;
    final brandId = session?.brandId;

    String? brandLogoUrl;
    if (brandId != null) {
      final brands = ref.read(brandNotifierProvider).valueOrNull ?? [];
      for (final b in brands) {
        if (b.id == brandId) {
          brandLogoUrl = b.logoUrl;
          break;
        }
      }
    }

    ref.read(inAppNotificationNotifierProvider.notifier).show(
          AppNotification(
            title: title,
            body: body,
            brandName: brandName,
            brandLogoUrl: brandLogoUrl,
          ),
        );
  }

  void _updateReconnecting(bool value) {
    if (_disposed) return;
    final current = state.value;
    if (current == null || current.isReconnecting == value) return;
    state = AsyncData(current.copyWith(isReconnecting: value));
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  void _cleanup() {
    _pollTimer?.cancel();
    _reconnectTimer?.cancel();
    _ws?.sink.close();
    _ws = null;
    // Release the app-level keepalive so AppOrderWatcher stops watching.
    ref.read(activeOrderNotifierProvider.notifier).clearActiveOrder();
  }
}
