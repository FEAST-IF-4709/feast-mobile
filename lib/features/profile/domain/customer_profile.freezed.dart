// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerProfile _$CustomerProfileFromJson(Map<String, dynamic> json) {
  return _CustomerProfile.fromJson(json);
}

/// @nodoc
mixin _$CustomerProfile {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_photo')
  String? get profilePhotoUrl => throw _privateConstructorUsedError; // M8: populated from GET /api/v1/customers/me/loyalty/
  int? get loyaltyPointsBalance =>
      throw _privateConstructorUsedError; // Transient — never from/to JSON; used for optimistic photo preview only.
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get localPhotoPath => throw _privateConstructorUsedError;

  /// Serializes this CustomerProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerProfileCopyWith<CustomerProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerProfileCopyWith<$Res> {
  factory $CustomerProfileCopyWith(
    CustomerProfile value,
    $Res Function(CustomerProfile) then,
  ) = _$CustomerProfileCopyWithImpl<$Res, CustomerProfile>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String? email,
    String phone,
    @JsonKey(name: 'profile_photo') String? profilePhotoUrl,
    int? loyaltyPointsBalance,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? localPhotoPath,
  });
}

/// @nodoc
class _$CustomerProfileCopyWithImpl<$Res, $Val extends CustomerProfile>
    implements $CustomerProfileCopyWith<$Res> {
  _$CustomerProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = freezed,
    Object? phone = null,
    Object? profilePhotoUrl = freezed,
    Object? loyaltyPointsBalance = freezed,
    Object? localPhotoPath = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            profilePhotoUrl: freezed == profilePhotoUrl
                ? _value.profilePhotoUrl
                : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            loyaltyPointsBalance: freezed == loyaltyPointsBalance
                ? _value.loyaltyPointsBalance
                : loyaltyPointsBalance // ignore: cast_nullable_to_non_nullable
                      as int?,
            localPhotoPath: freezed == localPhotoPath
                ? _value.localPhotoPath
                : localPhotoPath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerProfileImplCopyWith<$Res>
    implements $CustomerProfileCopyWith<$Res> {
  factory _$$CustomerProfileImplCopyWith(
    _$CustomerProfileImpl value,
    $Res Function(_$CustomerProfileImpl) then,
  ) = __$$CustomerProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String? email,
    String phone,
    @JsonKey(name: 'profile_photo') String? profilePhotoUrl,
    int? loyaltyPointsBalance,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? localPhotoPath,
  });
}

/// @nodoc
class __$$CustomerProfileImplCopyWithImpl<$Res>
    extends _$CustomerProfileCopyWithImpl<$Res, _$CustomerProfileImpl>
    implements _$$CustomerProfileImplCopyWith<$Res> {
  __$$CustomerProfileImplCopyWithImpl(
    _$CustomerProfileImpl _value,
    $Res Function(_$CustomerProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = freezed,
    Object? phone = null,
    Object? profilePhotoUrl = freezed,
    Object? loyaltyPointsBalance = freezed,
    Object? localPhotoPath = freezed,
  }) {
    return _then(
      _$CustomerProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        profilePhotoUrl: freezed == profilePhotoUrl
            ? _value.profilePhotoUrl
            : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        loyaltyPointsBalance: freezed == loyaltyPointsBalance
            ? _value.loyaltyPointsBalance
            : loyaltyPointsBalance // ignore: cast_nullable_to_non_nullable
                  as int?,
        localPhotoPath: freezed == localPhotoPath
            ? _value.localPhotoPath
            : localPhotoPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerProfileImpl implements _CustomerProfile {
  const _$CustomerProfileImpl({
    required this.id,
    @JsonKey(name: 'full_name') required this.fullName,
    this.email,
    required this.phone,
    @JsonKey(name: 'profile_photo') this.profilePhotoUrl,
    this.loyaltyPointsBalance,
    @JsonKey(includeFromJson: false, includeToJson: false)
    this.localPhotoPath = null,
  });

  factory _$CustomerProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerProfileImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String? email;
  @override
  final String phone;
  @override
  @JsonKey(name: 'profile_photo')
  final String? profilePhotoUrl;
  // M8: populated from GET /api/v1/customers/me/loyalty/
  @override
  final int? loyaltyPointsBalance;
  // Transient — never from/to JSON; used for optimistic photo preview only.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? localPhotoPath;

  @override
  String toString() {
    return 'CustomerProfile(id: $id, fullName: $fullName, email: $email, phone: $phone, profilePhotoUrl: $profilePhotoUrl, loyaltyPointsBalance: $loyaltyPointsBalance, localPhotoPath: $localPhotoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.profilePhotoUrl, profilePhotoUrl) ||
                other.profilePhotoUrl == profilePhotoUrl) &&
            (identical(other.loyaltyPointsBalance, loyaltyPointsBalance) ||
                other.loyaltyPointsBalance == loyaltyPointsBalance) &&
            (identical(other.localPhotoPath, localPhotoPath) ||
                other.localPhotoPath == localPhotoPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    email,
    phone,
    profilePhotoUrl,
    loyaltyPointsBalance,
    localPhotoPath,
  );

  /// Create a copy of CustomerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerProfileImplCopyWith<_$CustomerProfileImpl> get copyWith =>
      __$$CustomerProfileImplCopyWithImpl<_$CustomerProfileImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerProfileImplToJson(this);
  }
}

abstract class _CustomerProfile implements CustomerProfile {
  const factory _CustomerProfile({
    required final String id,
    @JsonKey(name: 'full_name') required final String fullName,
    final String? email,
    required final String phone,
    @JsonKey(name: 'profile_photo') final String? profilePhotoUrl,
    final int? loyaltyPointsBalance,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final String? localPhotoPath,
  }) = _$CustomerProfileImpl;

  factory _CustomerProfile.fromJson(Map<String, dynamic> json) =
      _$CustomerProfileImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String? get email;
  @override
  String get phone;
  @override
  @JsonKey(name: 'profile_photo')
  String? get profilePhotoUrl; // M8: populated from GET /api/v1/customers/me/loyalty/
  @override
  int? get loyaltyPointsBalance; // Transient — never from/to JSON; used for optimistic photo preview only.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get localPhotoPath;

  /// Create a copy of CustomerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerProfileImplCopyWith<_$CustomerProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
