// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrandImpl _$$BrandImplFromJson(Map<String, dynamic> json) => _$BrandImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  description: json['description'] as String?,
  cuisineType: json['cuisine_type'] as String?,
  logoUrl: json['logo_url'] as String?,
  bannerUrl: json['banner_url'] as String?,
  phone: json['phone'] as String?,
  locationAddress: json['location_address'] as String?,
  operatingHours: json['operating_hours'] as String?,
  isAcceptingOrders: json['is_accepting_orders'] as bool? ?? true,
  isBusyMode: json['is_busy_mode'] as bool? ?? false,
  latitude: const _DoubleFromStringConverter().fromJson(json['latitude']),
  longitude: const _DoubleFromStringConverter().fromJson(json['longitude']),
);

Map<String, dynamic> _$$BrandImplToJson(
  _$BrandImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'description': instance.description,
  'cuisine_type': instance.cuisineType,
  'logo_url': instance.logoUrl,
  'banner_url': instance.bannerUrl,
  'phone': instance.phone,
  'location_address': instance.locationAddress,
  'operating_hours': instance.operatingHours,
  'is_accepting_orders': instance.isAcceptingOrders,
  'is_busy_mode': instance.isBusyMode,
  'latitude': const _DoubleFromStringConverter().toJson(instance.latitude),
  'longitude': const _DoubleFromStringConverter().toJson(instance.longitude),
};
