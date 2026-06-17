// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutletImpl _$$OutletImplFromJson(Map<String, dynamic> json) => _$OutletImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  brandId: json['brand_id'] as String?,
  brandName: json['brand_name'] as String?,
  address: json['address'] as String?,
  latitude: const _DoubleFromStringConverter().fromJson(json['latitude']),
  longitude: const _DoubleFromStringConverter().fromJson(json['longitude']),
  distanceKm: (json['distance_km'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$OutletImplToJson(
  _$OutletImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand_id': instance.brandId,
  'brand_name': instance.brandName,
  'address': instance.address,
  'latitude': const _DoubleFromStringConverter().toJson(instance.latitude),
  'longitude': const _DoubleFromStringConverter().toJson(instance.longitude),
  'distance_km': instance.distanceKm,
};
