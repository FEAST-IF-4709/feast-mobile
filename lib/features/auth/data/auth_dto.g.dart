// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      if (instance.phone case final value?) 'phone': value,
      if (instance.email case final value?) 'email': value,
      'password': instance.password,
    };

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  phone: json['phone'] as String,
  fullName: json['full_name'] as String,
  password: json['password'] as String,
  email: json['email'] as String?,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'phone': instance.phone,
  'full_name': instance.fullName,
  'password': instance.password,
  if (instance.email case final value?) 'email': value,
};
