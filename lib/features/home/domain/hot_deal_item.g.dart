// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_deal_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HotDealItemImpl _$$HotDealItemImplFromJson(Map<String, dynamic> json) =>
    _$HotDealItemImpl(
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String?,
      productName: json['product_name'] as String,
      imageUrl: json['image_url'] as String?,
      originalPrice: json['original_price'] as String,
      effectivePrice: json['effective_price'] as String,
      discountType: json['discount_type'] as String,
      discountValue: json['discount_value'] as String,
      outletId: json['outlet_id'] as String?,
    );

Map<String, dynamic> _$$HotDealItemImplToJson(_$HotDealItemImpl instance) =>
    <String, dynamic>{
      'brand_id': instance.brandId,
      'brand_name': instance.brandName,
      'product_name': instance.productName,
      'image_url': instance.imageUrl,
      'original_price': instance.originalPrice,
      'effective_price': instance.effectivePrice,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'outlet_id': instance.outletId,
    };
