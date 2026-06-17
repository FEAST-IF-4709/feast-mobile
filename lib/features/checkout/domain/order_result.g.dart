// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderResultImpl _$$OrderResultImplFromJson(Map<String, dynamic> json) =>
    _$OrderResultImpl(
      orderId: json['order_id'] as String,
      orderNumber: json['order_number'] as String,
      subtotal: json['subtotal'] as String,
      discountTotal: json['discount_total'] as String? ?? '0',
      taxAmount: json['tax_amount'] as String,
      grandTotal: json['grand_total'] as String,
      validPaymentMethods: (json['valid_payment_methods'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$OrderResultImplToJson(_$OrderResultImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'order_number': instance.orderNumber,
      'subtotal': instance.subtotal,
      'discount_total': instance.discountTotal,
      'tax_amount': instance.taxAmount,
      'grand_total': instance.grandTotal,
      'valid_payment_methods': instance.validPaymentMethods,
    };
