import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/payment_repository.dart';
import '../domain/qris_payment.dart';

part 'payment_notifier.g.dart';

/// Manages the QRIS payment lifecycle for [orderId].
///
/// Responsibilities:
/// - Calls `initiate-qris/` on first build and on expiry (idempotent, CLAUDE.md §8.3).
/// - Schedules expiry timer; re-calls on expiry — no separate "regenerate" path.
///
/// Payment settlement detection is handled exclusively by [OrderTrackingNotifier]
/// via the shared `ws/order/{orderId}/` connection (CLAUDE.md §7.1).
@riverpod
class PaymentNotifier extends _$PaymentNotifier {
  Timer? _expiryTimer;

  @override
  Future<QrisPayment> build(String orderId) async {
    ref.onDispose(_cleanup);

    final qris =
        await ref.read(paymentRepositoryProvider).initiateQris(orderId);
    _scheduleRefresh(orderId, qris.expiresAt);

    return qris;
  }

  void _scheduleRefresh(String orderId, DateTime expiresAt) {
    _expiryTimer?.cancel();
    final delay = expiresAt.difference(DateTime.now());
    if (delay.isNegative) {
      _refresh(orderId);
      return;
    }
    _expiryTimer = Timer(delay, () => _refresh(orderId));
  }

  Future<void> _refresh(String orderId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final qris =
          await ref.read(paymentRepositoryProvider).initiateQris(orderId);
      _scheduleRefresh(orderId, qris.expiresAt);
      return qris;
    });
  }

  void _cleanup() {
    _expiryTimer?.cancel();
  }
}

/// Emits remaining time until [expiresAt], ticking every second.
///
/// Yields [Duration.zero] when expired; [PaymentNotifier] schedules the refresh.
@riverpod
Stream<Duration> paymentCountdown(
  PaymentCountdownRef ref,
  DateTime expiresAt,
) async* {
  while (true) {
    final remaining = expiresAt.difference(DateTime.now());
    if (remaining.isNegative) {
      yield Duration.zero;
      return;
    }
    yield remaining;
    await Future.delayed(const Duration(seconds: 1));
  }
}
