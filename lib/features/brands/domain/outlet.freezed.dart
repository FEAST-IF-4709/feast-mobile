// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outlet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Outlet _$OutletFromJson(Map<String, dynamic> json) {
  return _Outlet.fromJson(json);
}

/// @nodoc
mixin _$Outlet {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_id')
  String? get brandId => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_name')
  String? get brandName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @_DoubleFromStringConverter()
  double? get latitude => throw _privateConstructorUsedError;
  @_DoubleFromStringConverter()
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_km')
  double? get distanceKm => throw _privateConstructorUsedError;

  /// Serializes this Outlet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Outlet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutletCopyWith<Outlet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutletCopyWith<$Res> {
  factory $OutletCopyWith(Outlet value, $Res Function(Outlet) then) =
      _$OutletCopyWithImpl<$Res, Outlet>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'brand_id') String? brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    String? address,
    @_DoubleFromStringConverter() double? latitude,
    @_DoubleFromStringConverter() double? longitude,
    @JsonKey(name: 'distance_km') double? distanceKm,
  });
}

/// @nodoc
class _$OutletCopyWithImpl<$Res, $Val extends Outlet>
    implements $OutletCopyWith<$Res> {
  _$OutletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Outlet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brandId = freezed,
    Object? brandName = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distanceKm = freezed,
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
            brandId: freezed == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandName: freezed == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            distanceKm: freezed == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OutletImplCopyWith<$Res> implements $OutletCopyWith<$Res> {
  factory _$$OutletImplCopyWith(
    _$OutletImpl value,
    $Res Function(_$OutletImpl) then,
  ) = __$$OutletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'brand_id') String? brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    String? address,
    @_DoubleFromStringConverter() double? latitude,
    @_DoubleFromStringConverter() double? longitude,
    @JsonKey(name: 'distance_km') double? distanceKm,
  });
}

/// @nodoc
class __$$OutletImplCopyWithImpl<$Res>
    extends _$OutletCopyWithImpl<$Res, _$OutletImpl>
    implements _$$OutletImplCopyWith<$Res> {
  __$$OutletImplCopyWithImpl(
    _$OutletImpl _value,
    $Res Function(_$OutletImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Outlet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brandId = freezed,
    Object? brandName = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distanceKm = freezed,
  }) {
    return _then(
      _$OutletImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        brandId: freezed == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandName: freezed == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        distanceKm: freezed == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OutletImpl implements _Outlet {
  const _$OutletImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'brand_id') this.brandId,
    @JsonKey(name: 'brand_name') this.brandName,
    this.address,
    @_DoubleFromStringConverter() this.latitude,
    @_DoubleFromStringConverter() this.longitude,
    @JsonKey(name: 'distance_km') this.distanceKm,
  });

  factory _$OutletImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutletImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'brand_id')
  final String? brandId;
  @override
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @override
  final String? address;
  @override
  @_DoubleFromStringConverter()
  final double? latitude;
  @override
  @_DoubleFromStringConverter()
  final double? longitude;
  @override
  @JsonKey(name: 'distance_km')
  final double? distanceKm;

  @override
  String toString() {
    return 'Outlet(id: $id, name: $name, brandId: $brandId, brandName: $brandName, address: $address, latitude: $latitude, longitude: $longitude, distanceKm: $distanceKm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutletImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    brandId,
    brandName,
    address,
    latitude,
    longitude,
    distanceKm,
  );

  /// Create a copy of Outlet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutletImplCopyWith<_$OutletImpl> get copyWith =>
      __$$OutletImplCopyWithImpl<_$OutletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutletImplToJson(this);
  }
}

abstract class _Outlet implements Outlet {
  const factory _Outlet({
    required final String id,
    required final String name,
    @JsonKey(name: 'brand_id') final String? brandId,
    @JsonKey(name: 'brand_name') final String? brandName,
    final String? address,
    @_DoubleFromStringConverter() final double? latitude,
    @_DoubleFromStringConverter() final double? longitude,
    @JsonKey(name: 'distance_km') final double? distanceKm,
  }) = _$OutletImpl;

  factory _Outlet.fromJson(Map<String, dynamic> json) = _$OutletImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'brand_id')
  String? get brandId;
  @override
  @JsonKey(name: 'brand_name')
  String? get brandName;
  @override
  String? get address;
  @override
  @_DoubleFromStringConverter()
  double? get latitude;
  @override
  @_DoubleFromStringConverter()
  double? get longitude;
  @override
  @JsonKey(name: 'distance_km')
  double? get distanceKm;

  /// Create a copy of Outlet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutletImplCopyWith<_$OutletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
