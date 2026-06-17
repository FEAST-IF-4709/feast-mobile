// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qris_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QrisPaymentImpl _$$QrisPaymentImplFromJson(Map<String, dynamic> json) =>
    _$QrisPaymentImpl(
      transactionId: json['transaction_id'] as String,
      qrString: json['qr_string'] as String,
      qrImageUrl: json['qr_image_url'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$$QrisPaymentImplToJson(_$QrisPaymentImpl instance) =>
    <String, dynamic>{
      'transaction_id': instance.transactionId,
      'qr_string': instance.qrString,
      'qr_image_url': instance.qrImageUrl,
      'expires_at': instance.expiresAt.toIso8601String(),
      'amount': instance.amount,
    };
