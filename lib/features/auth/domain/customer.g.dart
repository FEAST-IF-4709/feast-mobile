// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      fullName: json['full_name'] as String,
      profilePhotoUrl: json['profile_photo'] as String?,
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'email': instance.email,
      'full_name': instance.fullName,
      'profile_photo': instance.profilePhotoUrl,
    };
