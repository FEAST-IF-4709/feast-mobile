// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeaturedBannerImpl _$$FeaturedBannerImplFromJson(Map<String, dynamic> json) =>
    _$FeaturedBannerImpl(
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String?,
      brandLogoUrl: json['brand_logo_url'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      imageUrl: json['image_url'] as String,
      targetOutletId: json['target_outlet_id'] as String?,
    );

Map<String, dynamic> _$$FeaturedBannerImplToJson(
  _$FeaturedBannerImpl instance,
) => <String, dynamic>{
  'brand_id': instance.brandId,
  'brand_name': instance.brandName,
  'brand_logo_url': instance.brandLogoUrl,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'image_url': instance.imageUrl,
  'target_outlet_id': instance.targetOutletId,
};
