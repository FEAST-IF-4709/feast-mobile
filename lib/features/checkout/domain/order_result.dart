import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_result.freezed.dart';
part 'order_result.g.dart';

/// Result from `POST /api/v1/orders/qr-table/`.
///
/// All monetary values are kept as String to avoid float precision issues.
/// Backend returns: subtotal, discount_total, tax_amount, grand_total.
@freezed
class OrderResult with _$OrderResult {
  const factory OrderResult({
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'order_number') required String orderNumber,
    @JsonKey(name: 'subtotal') required String subtotal,
    @JsonKey(name: 'discount_total') @Default('0') String discountTotal,
    @JsonKey(name: 'tax_amount') required String taxAmount,
    @JsonKey(name: 'grand_total') required String grandTotal,
    @JsonKey(name: 'valid_payment_methods')
    required List<String> validPaymentMethods,
  }) = _OrderResult;

  factory OrderResult.fromJson(Map<String, dynamic> json) =>
      _$OrderResultFromJson(json);
}
