// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PopularItemImpl _$$PopularItemImplFromJson(Map<String, dynamic> json) =>
    _$PopularItemImpl(
      outletProductId: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      imageUrl: json['image_url'] as String?,
      stockAvailable: json['stock_available'] as bool,
      activePromotion: json['active_promotion'] == null
          ? null
          : ActivePromotion.fromJson(
              json['active_promotion'] as Map<String, dynamic>,
            ),
      totalQtySold: (json['total_qty_sold'] as num).toInt(),
    );

Map<String, dynamic> _$$PopularItemImplToJson(_$PopularItemImpl instance) =>
    <String, dynamic>{
      'id': instance.outletProductId,
      'name': instance.name,
      'price': instance.price,
      'image_url': instance.imageUrl,
      'stock_available': instance.stockAvailable,
      'active_promotion': instance.activePromotion,
      'total_qty_sold': instance.totalQtySold,
    };
