// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_summary.freezed.dart';
part 'order_summary.g.dart';

/// Summary of one past order for the history list.
///
/// Sourced from GET /api/v1/me/orders/ (CustomerOrderSummarySerializer).
/// Backend returns outlet_name, brand_name, and item_count directly.
@freezed
class OrderSummary with _$OrderSummary {
  const factory OrderSummary({
    required String id,
    @JsonKey(name: 'order_number') required String orderNumber,
    @JsonKey(name: 'outlet_name') @Default('') String outletName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'grand_total') required String grandTotal,
    @JsonKey(name: 'fulfillment_status') required String fulfillmentStatus,
    @JsonKey(name: 'placed_at') required DateTime placedAt,
    @JsonKey(name: 'item_count') @Default(0) int itemCount,
  }) = _OrderSummary;

  factory OrderSummary.fromJson(Map<String, dynamic> json) =>
      _$OrderSummaryFromJson(json);
}
