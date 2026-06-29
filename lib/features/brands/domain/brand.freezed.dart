// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Brand _$BrandFromJson(Map<String, dynamic> json) {
  return _Brand.fromJson(json);
}

/// @nodoc
mixin _$Brand {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'cuisine_type')
  String? get cuisineType => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_url')
  String? get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'banner_url')
  String? get bannerUrl => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_address')
  String? get locationAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'operating_hours')
  String? get operatingHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_accepting_orders')
  bool get isAcceptingOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_busy_mode')
  bool get isBusyMode => throw _privateConstructorUsedError;
  @_DoubleFromStringConverter()
  double? get latitude => throw _privateConstructorUsedError;
  @_DoubleFromStringConverter()
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this Brand to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Brand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandCopyWith<Brand> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandCopyWith<$Res> {
  factory $BrandCopyWith(Brand value, $Res Function(Brand) then) =
      _$BrandCopyWithImpl<$Res, Brand>;
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    String? description,
    @JsonKey(name: 'cuisine_type') String? cuisineType,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'banner_url') String? bannerUrl,
    String? phone,
    @JsonKey(name: 'location_address') String? locationAddress,
    @JsonKey(name: 'operating_hours') String? operatingHours,
    @JsonKey(name: 'is_accepting_orders') bool isAcceptingOrders,
    @JsonKey(name: 'is_busy_mode') bool isBusyMode,
    @_DoubleFromStringConverter() double? latitude,
    @_DoubleFromStringConverter() double? longitude,
  });
}

/// @nodoc
class _$BrandCopyWithImpl<$Res, $Val extends Brand>
    implements $BrandCopyWith<$Res> {
  _$BrandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Brand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? cuisineType = freezed,
    Object? logoUrl = freezed,
    Object? bannerUrl = freezed,
    Object? phone = freezed,
    Object? locationAddress = freezed,
    Object? operatingHours = freezed,
    Object? isAcceptingOrders = null,
    Object? isBusyMode = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            cuisineType: freezed == cuisineType
                ? _value.cuisineType
                : cuisineType // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bannerUrl: freezed == bannerUrl
                ? _value.bannerUrl
                : bannerUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationAddress: freezed == locationAddress
                ? _value.locationAddress
                : locationAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            operatingHours: freezed == operatingHours
                ? _value.operatingHours
                : operatingHours // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAcceptingOrders: null == isAcceptingOrders
                ? _value.isAcceptingOrders
                : isAcceptingOrders // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBusyMode: null == isBusyMode
                ? _value.isBusyMode
                : isBusyMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrandImplCopyWith<$Res> implements $BrandCopyWith<$Res> {
  factory _$$BrandImplCopyWith(
    _$BrandImpl value,
    $Res Function(_$BrandImpl) then,
  ) = __$$BrandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String slug,
    String? description,
    @JsonKey(name: 'cuisine_type') String? cuisineType,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'banner_url') String? bannerUrl,
    String? phone,
    @JsonKey(name: 'location_address') String? locationAddress,
    @JsonKey(name: 'operating_hours') String? operatingHours,
    @JsonKey(name: 'is_accepting_orders') bool isAcceptingOrders,
    @JsonKey(name: 'is_busy_mode') bool isBusyMode,
    @_DoubleFromStringConverter() double? latitude,
    @_DoubleFromStringConverter() double? longitude,
  });
}

/// @nodoc
class __$$BrandImplCopyWithImpl<$Res>
    extends _$BrandCopyWithImpl<$Res, _$BrandImpl>
    implements _$$BrandImplCopyWith<$Res> {
  __$$BrandImplCopyWithImpl(
    _$BrandImpl _value,
    $Res Function(_$BrandImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Brand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? cuisineType = freezed,
    Object? logoUrl = freezed,
    Object? bannerUrl = freezed,
    Object? phone = freezed,
    Object? locationAddress = freezed,
    Object? operatingHours = freezed,
    Object? isAcceptingOrders = null,
    Object? isBusyMode = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _$BrandImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        cuisineType: freezed == cuisineType
            ? _value.cuisineType
            : cuisineType // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bannerUrl: freezed == bannerUrl
            ? _value.bannerUrl
            : bannerUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationAddress: freezed == locationAddress
            ? _value.locationAddress
            : locationAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        operatingHours: freezed == operatingHours
            ? _value.operatingHours
            : operatingHours // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAcceptingOrders: null == isAcceptingOrders
            ? _value.isAcceptingOrders
            : isAcceptingOrders // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBusyMode: null == isBusyMode
            ? _value.isBusyMode
            : isBusyMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BrandImpl implements _Brand {
  const _$BrandImpl({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    @JsonKey(name: 'cuisine_type') this.cuisineType,
    @JsonKey(name: 'logo_url') this.logoUrl,
    @JsonKey(name: 'banner_url') this.bannerUrl,
    this.phone,
    @JsonKey(name: 'location_address') this.locationAddress,
    @JsonKey(name: 'operating_hours') this.operatingHours,
    @JsonKey(name: 'is_accepting_orders') this.isAcceptingOrders = true,
    @JsonKey(name: 'is_busy_mode') this.isBusyMode = false,
    @_DoubleFromStringConverter() this.latitude,
    @_DoubleFromStringConverter() this.longitude,
  });

  factory _$BrandImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrandImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  @JsonKey(name: 'cuisine_type')
  final String? cuisineType;
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @override
  @JsonKey(name: 'banner_url')
  final String? bannerUrl;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'location_address')
  final String? locationAddress;
  @override
  @JsonKey(name: 'operating_hours')
  final String? operatingHours;
  @override
  @JsonKey(name: 'is_accepting_orders')
  final bool isAcceptingOrders;
  @override
  @JsonKey(name: 'is_busy_mode')
  final bool isBusyMode;
  @override
  @_DoubleFromStringConverter()
  final double? latitude;
  @override
  @_DoubleFromStringConverter()
  final double? longitude;

  @override
  String toString() {
    return 'Brand(id: $id, name: $name, slug: $slug, description: $description, cuisineType: $cuisineType, logoUrl: $logoUrl, bannerUrl: $bannerUrl, phone: $phone, locationAddress: $locationAddress, operatingHours: $operatingHours, isAcceptingOrders: $isAcceptingOrders, isBusyMode: $isBusyMode, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cuisineType, cuisineType) ||
                other.cuisineType == cuisineType) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.locationAddress, locationAddress) ||
                other.locationAddress == locationAddress) &&
            (identical(other.operatingHours, operatingHours) ||
                other.operatingHours == operatingHours) &&
            (identical(other.isAcceptingOrders, isAcceptingOrders) ||
                other.isAcceptingOrders == isAcceptingOrders) &&
            (identical(other.isBusyMode, isBusyMode) ||
                other.isBusyMode == isBusyMode) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    description,
    cuisineType,
    logoUrl,
    bannerUrl,
    phone,
    locationAddress,
    operatingHours,
    isAcceptingOrders,
    isBusyMode,
    latitude,
    longitude,
  );

  /// Create a copy of Brand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandImplCopyWith<_$BrandImpl> get copyWith =>
      __$$BrandImplCopyWithImpl<_$BrandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrandImplToJson(this);
  }
}

abstract class _Brand implements Brand {
  const factory _Brand({
    required final String id,
    required final String name,
    required final String slug,
    final String? description,
    @JsonKey(name: 'cuisine_type') final String? cuisineType,
    @JsonKey(name: 'logo_url') final String? logoUrl,
    @JsonKey(name: 'banner_url') final String? bannerUrl,
    final String? phone,
    @JsonKey(name: 'location_address') final String? locationAddress,
    @JsonKey(name: 'operating_hours') final String? operatingHours,
    @JsonKey(name: 'is_accepting_orders') final bool isAcceptingOrders,
    @JsonKey(name: 'is_busy_mode') final bool isBusyMode,
    @_DoubleFromStringConverter() final double? latitude,
    @_DoubleFromStringConverter() final double? longitude,
  }) = _$BrandImpl;

  factory _Brand.fromJson(Map<String, dynamic> json) = _$BrandImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String? get description;
  @override
  @JsonKey(name: 'cuisine_type')
  String? get cuisineType;
  @override
  @JsonKey(name: 'logo_url')
  String? get logoUrl;
  @override
  @JsonKey(name: 'banner_url')
  String? get bannerUrl;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'location_address')
  String? get locationAddress;
  @override
  @JsonKey(name: 'operating_hours')
  String? get operatingHours;
  @override
  @JsonKey(name: 'is_accepting_orders')
  bool get isAcceptingOrders;
  @override
  @JsonKey(name: 'is_busy_mode')
  bool get isBusyMode;
  @override
  @_DoubleFromStringConverter()
  double? get latitude;
  @override
  @_DoubleFromStringConverter()
  double? get longitude;

  /// Create a copy of Brand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandImplCopyWith<_$BrandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
