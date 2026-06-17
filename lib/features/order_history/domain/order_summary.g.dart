// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderSummaryImpl _$$OrderSummaryImplFromJson(Map<String, dynamic> json) =>
    _$OrderSummaryImpl(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      outletName: json['outlet_name'] as String? ?? '',
      brandName: json['brand_name'] as String?,
      grandTotal: json['grand_total'] as String,
      fulfillmentStatus: json['fulfillment_status'] as String,
      placedAt: DateTime.parse(json['placed_at'] as String),
      itemCount: (json['item_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OrderSummaryImplToJson(_$OrderSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'outlet_name': instance.outletName,
      'brand_name': instance.brandName,
      'grand_total': instance.grandTotal,
      'fulfillment_status': instance.fulfillmentStatus,
      'placed_at': instance.placedAt.toIso8601String(),
      'item_count': instance.itemCount,
    };
