import 'package:freezed_annotation/freezed_annotation.dart';

part 'qris_payment.freezed.dart';
part 'qris_payment.g.dart';

/// Result from `POST /api/v1/payments/initiate-qris/`.
///
/// [qrString] is raw EMV QR data rendered locally with qr_flutter.
/// [expiresAt] drives the 15-minute countdown; on expiry the screen
/// re-calls initiate-qris (idempotent — same QR if not yet expired).
@freezed
class QrisPayment with _$QrisPayment {
  const factory QrisPayment({
    @JsonKey(name: 'transaction_id') required String transactionId,
    @JsonKey(name: 'qr_string') required String qrString,
    @JsonKey(name: 'qr_image_url') required String qrImageUrl,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
    required String amount,
  }) = _QrisPayment;

  factory QrisPayment.fromJson(Map<String, dynamic> json) =>
      _$QrisPaymentFromJson(json);
}
