// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FeaturedBanner _$FeaturedBannerFromJson(Map<String, dynamic> json) {
  return _FeaturedBanner.fromJson(json);
}

/// @nodoc
mixin _$FeaturedBanner {
  @JsonKey(name: 'brand_id')
  String get brandId => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_name')
  String? get brandName => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_logo_url')
  String? get brandLogoUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_outlet_id')
  String? get targetOutletId => throw _privateConstructorUsedError;

  /// Serializes this FeaturedBanner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedBannerCopyWith<FeaturedBanner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedBannerCopyWith<$Res> {
  factory $FeaturedBannerCopyWith(
    FeaturedBanner value,
    $Res Function(FeaturedBanner) then,
  ) = _$FeaturedBannerCopyWithImpl<$Res, FeaturedBanner>;
  @useResult
  $Res call({
    @JsonKey(name: 'brand_id') String brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'brand_logo_url') String? brandLogoUrl,
    String title,
    String subtitle,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'target_outlet_id') String? targetOutletId,
  });
}

/// @nodoc
class _$FeaturedBannerCopyWithImpl<$Res, $Val extends FeaturedBanner>
    implements $FeaturedBannerCopyWith<$Res> {
  _$FeaturedBannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? brandName = freezed,
    Object? brandLogoUrl = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = null,
    Object? targetOutletId = freezed,
  }) {
    return _then(
      _value.copyWith(
            brandId: null == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as String,
            brandName: freezed == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandLogoUrl: freezed == brandLogoUrl
                ? _value.brandLogoUrl
                : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            targetOutletId: freezed == targetOutletId
                ? _value.targetOutletId
                : targetOutletId // ignore: cast_nullable_to_non_nullable
                       as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeaturedBannerImplCopyWith<$Res>
    implements $FeaturedBannerCopyWith<$Res> {
  factory _$$FeaturedBannerImplCopyWith(
    _$FeaturedBannerImpl value,
    $Res Function(_$FeaturedBannerImpl) then,
  ) = __$$FeaturedBannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'brand_id') String brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'brand_logo_url') String? brandLogoUrl,
    String title,
    String subtitle,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'target_outlet_id') String? targetOutletId,
  });
}

/// @nodoc
class __$$FeaturedBannerImplCopyWithImpl<$Res>
    extends _$FeaturedBannerCopyWithImpl<$Res, _$FeaturedBannerImpl>
    implements _$$FeaturedBannerImplCopyWith<$Res> {
  __$$FeaturedBannerImplCopyWithImpl(
    _$FeaturedBannerImpl _value,
    $Res Function(_$FeaturedBannerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeaturedBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? brandName = freezed,
    Object? brandLogoUrl = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = null,
    Object? targetOutletId = freezed,
  }) {
    return _then(
      _$FeaturedBannerImpl(
        brandId: null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
        brandName: freezed == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandLogoUrl: freezed == brandLogoUrl
            ? _value.brandLogoUrl
            : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        targetOutletId: freezed == targetOutletId
            ? _value.targetOutletId
            : targetOutletId // ignore: cast_nullable_to_non_nullable
                   as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedBannerImpl implements _FeaturedBanner {
  const _$FeaturedBannerImpl({
    @JsonKey(name: 'brand_id') required this.brandId,
    @JsonKey(name: 'brand_name') this.brandName,
    @JsonKey(name: 'brand_logo_url') this.brandLogoUrl,
    required this.title,
    this.subtitle = '',
    @JsonKey(name: 'image_url') required this.imageUrl,
    @JsonKey(name: 'target_outlet_id') this.targetOutletId,
  });

  factory _$FeaturedBannerImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedBannerImplFromJson(json);

  @override
  @JsonKey(name: 'brand_id')
  final String brandId;
  @override
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @override
  @JsonKey(name: 'brand_logo_url')
  final String? brandLogoUrl;
  @override
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'target_outlet_id')
  final String? targetOutletId;

  @override
  String toString() {
    return 'FeaturedBanner(brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, targetOutletId: $targetOutletId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedBannerImpl &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandLogoUrl, brandLogoUrl) ||
                other.brandLogoUrl == brandLogoUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.targetOutletId, targetOutletId) ||
                other.targetOutletId == targetOutletId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    brandId,
    brandName,
    brandLogoUrl,
    title,
    subtitle,
    imageUrl,
    targetOutletId,
  );

  /// Create a copy of FeaturedBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedBannerImplCopyWith<_$FeaturedBannerImpl> get copyWith =>
      __$$FeaturedBannerImplCopyWithImpl<_$FeaturedBannerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedBannerImplToJson(this);
  }
}

abstract class _FeaturedBanner implements FeaturedBanner {
  const factory _FeaturedBanner({
    @JsonKey(name: 'brand_id') required final String brandId,
    @JsonKey(name: 'brand_name') final String? brandName,
    @JsonKey(name: 'brand_logo_url') final String? brandLogoUrl,
    required final String title,
    final String subtitle,
    @JsonKey(name: 'image_url') required final String imageUrl,
    @JsonKey(name: 'target_outlet_id') final String? targetOutletId,
  }) = _$FeaturedBannerImpl;

  factory _FeaturedBanner.fromJson(Map<String, dynamic> json) =
      _$FeaturedBannerImpl.fromJson;

  @override
  @JsonKey(name: 'brand_id')
  String get brandId;
  @override
  @JsonKey(name: 'brand_name')
  String? get brandName;
  @override
  @JsonKey(name: 'brand_logo_url')
  String? get brandLogoUrl;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'target_outlet_id')
  String? get targetOutletId;

  /// Create a copy of FeaturedBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedBannerImplCopyWith<_$FeaturedBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
