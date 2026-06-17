// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerProfileImpl _$$CustomerProfileImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerProfileImpl(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String,
  profilePhotoUrl: json['profile_photo'] as String?,
  loyaltyPointsBalance: (json['loyaltyPointsBalance'] as num?)?.toInt(),
);

Map<String, dynamic> _$$CustomerProfileImplToJson(
  _$CustomerProfileImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'profile_photo': instance.profilePhotoUrl,
  'loyaltyPointsBalance': instance.loyaltyPointsBalance,
};
