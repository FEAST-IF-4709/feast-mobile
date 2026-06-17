// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemImpl _$$MenuItemImplFromJson(Map<String, dynamic> json) =>
    _$MenuItemImpl(
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
    );

Map<String, dynamic> _$$MenuItemImplToJson(_$MenuItemImpl instance) =>
    <String, dynamic>{
      'id': instance.outletProductId,
      'name': instance.name,
      'price': instance.price,
      'image_url': instance.imageUrl,
      'stock_available': instance.stockAvailable,
      'active_promotion': instance.activePromotion,
    };

_$ActivePromotionImpl _$$ActivePromotionImplFromJson(
  Map<String, dynamic> json,
) => _$ActivePromotionImpl(
  discountType: json['discount_type'] as String,
  discountValue: json['discount_value'] as String,
);

Map<String, dynamic> _$$ActivePromotionImplToJson(
  _$ActivePromotionImpl instance,
) => <String, dynamic>{
  'discount_type': instance.discountType,
  'discount_value': instance.discountValue,
};

_$MenuCategoryImpl _$$MenuCategoryImplFromJson(Map<String, dynamic> json) =>
    _$MenuCategoryImpl(
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MenuCategoryImplToJson(_$MenuCategoryImpl instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'items': instance.items,
    };
