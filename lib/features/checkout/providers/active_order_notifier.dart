import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';

part 'active_order_notifier.g.dart';

/// Persists the ID of the order that is currently in-flight (payment pending
/// through to terminal fulfillment status).
///
/// Kept alive so [AppOrderWatcher] can hold a permanent listener on
/// [OrderTrackingNotifier] regardless of which screen is visible — ensuring
/// the WebSocket stays connected and in-app notifications fire everywhere.
///
/// Lifecycle:
///   set  → [CartScreen] calls [setActiveOrder] right after `createOrder`.
///   clear → [OrderTrackingNotifier] calls [clearActiveOrder] when the order
///            reaches a terminal fulfillment status (SERVED / COMPLETED /
///            CANCELLED).
@Riverpod(keepAlive: true)
class ActiveOrderNotifier extends _$ActiveOrderNotifier {
  @override
  Future<String?> build() async {
    return ref.read(preferencesServiceProvider).getActiveOrderId();
  }

  Future<void> setActiveOrder(String orderId) async {
    await ref.read(preferencesServiceProvider).saveActiveOrderId(orderId);
    state = AsyncData(orderId);
  }

  Future<void> clearActiveOrder() async {
    await ref.read(preferencesServiceProvider).clearActiveOrderId();
    state = const AsyncData(null);
  }
}
