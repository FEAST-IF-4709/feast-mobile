import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/checkout/providers/active_order_notifier.dart';
import '../../features/notifications/domain/app_notification_entry.dart';
import '../../features/notifications/providers/notification_history_notifier.dart';
import '../../features/order_tracking/domain/fulfillment_status.dart';
import '../../features/order_tracking/domain/order_tracking_state.dart';
import '../../features/order_tracking/providers/order_tracking_notifier.dart';

/// Invisible widget that keeps [OrderTrackingNotifier] alive for the duration
/// of an active order — regardless of which screen the user is on.
///
/// Mount once at the app root (inside [MaterialApp.router]'s `builder`).
/// When [activeOrderNotifierProvider] holds an order ID, this widget subscribes
/// to [orderTrackingNotifierProvider] as a permanent listener. That subscription
/// prevents Riverpod from auto-disposing the notifier (and its WebSocket) when
/// the user navigates away from [PaymentScreen] or [OrderTrackingScreen].
///
/// In-app notifications are still fired by [OrderTrackingNotifier] itself;
/// this widget only manages the provider's lifetime.
class AppOrderWatcher extends ConsumerWidget {
  const AppOrderWatcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeOrderAsync = ref.watch(activeOrderNotifierProvider);
    final orderId = activeOrderAsync.valueOrNull;

    if (orderId == null) return const SizedBox.shrink();

    return _ActiveOrderKeepAlive(orderId: orderId);
  }
}

/// Separate widget so the [orderTrackingNotifierProvider] subscription is
/// created and destroyed cleanly as [orderId] appears / disappears.
class _ActiveOrderKeepAlive extends ConsumerWidget {
  const _ActiveOrderKeepAlive({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingAsync = ref.watch(orderTrackingNotifierProvider(orderId));

    // Feed persistent notification history whenever fulfillment status changes.
    ref.listen<AsyncValue<OrderTrackingState>>(
      orderTrackingNotifierProvider(orderId),
      (previous, next) {
        final prevStatus = previous?.valueOrNull?.fulfillmentStatus;
        final nextStatus = next.valueOrNull?.fulfillmentStatus;

        if (nextStatus == null || nextStatus == prevStatus) return;

        final (title, body) = _notificationText(nextStatus);
        if (title == null) return;

        ref.read(notificationHistoryNotifierProvider.notifier).add(
              AppNotificationEntry(
                id: '${orderId}_${nextStatus.value}',
                title: title,
                body: body!,
                timestamp: DateTime.now(),
                orderId: orderId,
                isRead: false,
              ),
            );
      },
    );

    // When the order reaches a terminal fulfillment status, clear the active
    // order so this watcher stops holding the provider alive.
    final status = trackingAsync.valueOrNull?.fulfillmentStatus;
    if (status != null && status.isTerminal) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(activeOrderNotifierProvider.notifier).clearActiveOrder();
      });
    }

    return const SizedBox.shrink();
  }

  /// Returns (title, body) for statuses that warrant a history entry, or
  /// (null, null) for statuses we intentionally skip (e.g. RECEIVED, which
  /// the payment confirmation screen already handles).
  (String?, String?) _notificationText(FulfillmentStatus status) =>
      switch (status) {
        FulfillmentStatus.inProgress => (
            'Sedang Dimasak',
            'Chef sedang menyiapkan pesananmu.',
          ),
        FulfillmentStatus.ready => (
            'Pesanan Siap!',
            'Pesananmu siap untuk disajikan.',
          ),
        FulfillmentStatus.served => (
            'Selamat Menikmati!',
            'Pesananmu telah tersaji di mejamu.',
          ),
        FulfillmentStatus.completed => (
            'Pesanan Selesai',
            'Terima kasih sudah memesan!',
          ),
        FulfillmentStatus.cancelled => (
            'Pesanan Dibatalkan',
            'Pesananmu telah dibatalkan.',
          ),
        _ => (null, null),
      };
}
