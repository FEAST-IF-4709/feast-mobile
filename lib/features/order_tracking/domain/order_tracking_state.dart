import 'package:freezed_annotation/freezed_annotation.dart';

import 'fulfillment_status.dart';

part 'order_tracking_state.freezed.dart';

/// One line item in a tracked order — parsed from `GET /api/v1/orders/{id}/`.
@freezed
class TrackingOrderItem with _$TrackingOrderItem {
  const factory TrackingOrderItem({
    required String productName,
    required int quantity,
    required String unitPrice,
    required String lineTotal,
    String? itemNotes,
    String? imageUrl,
  }) = _TrackingOrderItem;
}

/// Composite state for the order tracking screen.
///
/// [fulfillmentStatus] is the source of truth for the 5-step stepper.
/// [paymentSettled] transitions to `true` on `payment.status_changed: SETTLED`
/// and is read by [PaymentScreen] to trigger navigation to this screen.
/// [isReconnecting] is `true` while the WebSocket is between disconnect and
/// a successful re-connect — the UI shows an amber "reconnecting" banner.
@freezed
class OrderTrackingState with _$OrderTrackingState {
  const factory OrderTrackingState({
    required FulfillmentStatus fulfillmentStatus,
    @Default(false) bool paymentSettled,
    @Default(false) bool isReconnecting,
    @Default([]) List<TrackingOrderItem> orderItems,
    String? orderNumber,
    String? subtotal,
    String? taxAmount,
    String? grandTotal,
    String? orderNotes,
  }) = _OrderTrackingState;
}
