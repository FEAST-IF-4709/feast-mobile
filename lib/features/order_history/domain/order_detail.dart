// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_detail.freezed.dart';
part 'order_detail.g.dart';

/// Single line item inside an order detail response (OrderItemSerializer).
///
/// [productName] comes from the backend's SerializerMethodField on product_snapshot.
@freezed
class OrderDetailItem with _$OrderDetailItem {
  const factory OrderDetailItem({
    @JsonKey(name: 'product_name') String? productName,
    required int quantity,
    @JsonKey(name: 'unit_price') required String unitPrice,
    @JsonKey(name: 'line_total') required String lineTotal,
    @JsonKey(name: 'item_notes') String? itemNotes,
  }) = _OrderDetailItem;

  factory OrderDetailItem.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailItemFromJson(json);
}

/// Full order detail from GET /api/v1/orders/{pk}/ (CustomerOrderDetailSerializer for customers).
///
/// When accessed by a customer, the backend returns outlet_name and brand_name
/// directly. Staff access still uses OrderDetailSerializer (no outlet name fields).
/// [taxAmount] is optional — returned by OrderSerializer if present.
/// Subtotal is derived client-side by summing [items] line_total values.
@freezed
class OrderDetail with _$OrderDetail {
  const factory OrderDetail({
    required String id,
    @JsonKey(name: 'order_number') required String orderNumber,
    @JsonKey(name: 'outlet_name') @Default('') String outletName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'outlet_address') String? outletAddress,
    @JsonKey(name: 'brand_logo_url') String? brandLogoUrl,
    @JsonKey(name: 'tax_amount') String? taxAmount,
    @JsonKey(name: 'grand_total') required String grandTotal,
    @JsonKey(name: 'fulfillment_status') required String fulfillmentStatus,
    @JsonKey(name: 'placed_at') required DateTime placedAt,
    String? notes,
    @Default([]) List<OrderDetailItem> items,
  }) = _OrderDetail;

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
}
