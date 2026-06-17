// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderDetailItemImpl _$$OrderDetailItemImplFromJson(
  Map<String, dynamic> json,
) => _$OrderDetailItemImpl(
  productName: json['product_name'] as String?,
  quantity: (json['quantity'] as num).toInt(),
  unitPrice: json['unit_price'] as String,
  lineTotal: json['line_total'] as String,
  itemNotes: json['item_notes'] as String?,
);

Map<String, dynamic> _$$OrderDetailItemImplToJson(
  _$OrderDetailItemImpl instance,
) => <String, dynamic>{
  'product_name': instance.productName,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'line_total': instance.lineTotal,
  'item_notes': instance.itemNotes,
};

_$OrderDetailImpl _$$OrderDetailImplFromJson(Map<String, dynamic> json) =>
    _$OrderDetailImpl(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      outletName: json['outlet_name'] as String? ?? '',
      brandName: json['brand_name'] as String?,
      taxAmount: json['tax_amount'] as String?,
      grandTotal: json['grand_total'] as String,
      fulfillmentStatus: json['fulfillment_status'] as String,
      placedAt: DateTime.parse(json['placed_at'] as String),
      notes: json['notes'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => OrderDetailItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderDetailImplToJson(_$OrderDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'outlet_name': instance.outletName,
      'brand_name': instance.brandName,
      'tax_amount': instance.taxAmount,
      'grand_total': instance.grandTotal,
      'fulfillment_status': instance.fulfillmentStatus,
      'placed_at': instance.placedAt.toIso8601String(),
      'notes': instance.notes,
      'items': instance.items,
    };
