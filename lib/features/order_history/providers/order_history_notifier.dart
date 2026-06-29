import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/order_history_repository.dart';
import '../domain/order_detail.dart';
import '../domain/order_summary.dart';

part 'order_history_notifier.g.dart';

/// Fetches and holds the list of the customer's past orders.
///
/// Invalidate via [ref.invalidate(orderHistoryNotifierProvider)] to force a
/// refresh (e.g. pull-to-refresh).
@Riverpod(keepAlive: true)
class OrderHistoryNotifier extends _$OrderHistoryNotifier {
  @override
  Future<List<OrderSummary>> build() =>
      ref.read(orderHistoryRepositoryProvider).getOrders();
}

/// Fetches the full detail for a single order keyed by [orderId].
@riverpod
Future<OrderDetail> orderDetail(OrderDetailRef ref, String orderId) =>
    ref.read(orderHistoryRepositoryProvider).getOrderDetail(orderId);
