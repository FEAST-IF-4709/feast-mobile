// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hot_deal_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HotDealItem _$HotDealItemFromJson(Map<String, dynamic> json) {
  return _HotDealItem.fromJson(json);
}

/// @nodoc
mixin _$HotDealItem {
  @JsonKey(name: 'brand_id')
  String get brandId => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_name')
  String? get brandName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_price')
  String get originalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'effective_price')
  String get effectivePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_type')
  String get discountType => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_value')
  String get discountValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'outlet_id')
  String? get outletId => throw _privateConstructorUsedError;

  /// Serializes this HotDealItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HotDealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HotDealItemCopyWith<HotDealItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotDealItemCopyWith<$Res> {
  factory $HotDealItemCopyWith(
    HotDealItem value,
    $Res Function(HotDealItem) then,
  ) = _$HotDealItemCopyWithImpl<$Res, HotDealItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'brand_id') String brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'original_price') String originalPrice,
    @JsonKey(name: 'effective_price') String effectivePrice,
    @JsonKey(name: 'discount_type') String discountType,
    @JsonKey(name: 'discount_value') String discountValue,
    @JsonKey(name: 'outlet_id') String? outletId,
  });
}

/// @nodoc
class _$HotDealItemCopyWithImpl<$Res, $Val extends HotDealItem>
    implements $HotDealItemCopyWith<$Res> {
  _$HotDealItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HotDealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? brandName = freezed,
    Object? productName = null,
    Object? imageUrl = freezed,
    Object? originalPrice = null,
    Object? effectivePrice = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? outletId = freezed,
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
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalPrice: null == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as String,
            effectivePrice: null == effectivePrice
                ? _value.effectivePrice
                : effectivePrice // ignore: cast_nullable_to_non_nullable
                      as String,
            discountType: null == discountType
                ? _value.discountType
                : discountType // ignore: cast_nullable_to_non_nullable
                      as String,
            discountValue: null == discountValue
                ? _value.discountValue
                : discountValue // ignore: cast_nullable_to_non_nullable
                      as String,
            outletId: freezed == outletId
                ? _value.outletId
                : outletId // ignore: cast_nullable_to_non_nullable
                       as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HotDealItemImplCopyWith<$Res>
    implements $HotDealItemCopyWith<$Res> {
  factory _$$HotDealItemImplCopyWith(
    _$HotDealItemImpl value,
    $Res Function(_$HotDealItemImpl) then,
  ) = __$$HotDealItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'brand_id') String brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'original_price') String originalPrice,
    @JsonKey(name: 'effective_price') String effectivePrice,
    @JsonKey(name: 'discount_type') String discountType,
    @JsonKey(name: 'discount_value') String discountValue,
    @JsonKey(name: 'outlet_id') String? outletId,
  });
}

/// @nodoc
class __$$HotDealItemImplCopyWithImpl<$Res>
    extends _$HotDealItemCopyWithImpl<$Res, _$HotDealItemImpl>
    implements _$$HotDealItemImplCopyWith<$Res> {
  __$$HotDealItemImplCopyWithImpl(
    _$HotDealItemImpl _value,
    $Res Function(_$HotDealItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HotDealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandId = null,
    Object? brandName = freezed,
    Object? productName = null,
    Object? imageUrl = freezed,
    Object? originalPrice = null,
    Object? effectivePrice = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? outletId = freezed,
  }) {
    return _then(
      _$HotDealItemImpl(
        brandId: null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
        brandName: freezed == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String?,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalPrice: null == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as String,
        effectivePrice: null == effectivePrice
            ? _value.effectivePrice
            : effectivePrice // ignore: cast_nullable_to_non_nullable
                  as String,
        discountType: null == discountType
            ? _value.discountType
            : discountType // ignore: cast_nullable_to_non_nullable
                  as String,
        discountValue: null == discountValue
            ? _value.discountValue
            : discountValue // ignore: cast_nullable_to_non_nullable
                  as String,
        outletId: freezed == outletId
            ? _value.outletId
            : outletId // ignore: cast_nullable_to_non_nullable
                   as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HotDealItemImpl implements _HotDealItem {
  const _$HotDealItemImpl({
    @JsonKey(name: 'brand_id') required this.brandId,
    @JsonKey(name: 'brand_name') this.brandName,
    @JsonKey(name: 'product_name') required this.productName,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'original_price') required this.originalPrice,
    @JsonKey(name: 'effective_price') required this.effectivePrice,
    @JsonKey(name: 'discount_type') required this.discountType,
    @JsonKey(name: 'discount_value') required this.discountValue,
    @JsonKey(name: 'outlet_id') this.outletId,
  });

  factory _$HotDealItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$HotDealItemImplFromJson(json);

  @override
  @JsonKey(name: 'brand_id')
  final String brandId;
  @override
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'original_price')
  final String originalPrice;
  @override
  @JsonKey(name: 'effective_price')
  final String effectivePrice;
  @override
  @JsonKey(name: 'discount_type')
  final String discountType;
  @override
  @JsonKey(name: 'discount_value')
  final String discountValue;
  @override
  @JsonKey(name: 'outlet_id')
  final String? outletId;

  @override
  String toString() {
    return 'HotDealItem(brandId: $brandId, brandName: $brandName, productName: $productName, imageUrl: $imageUrl, originalPrice: $originalPrice, effectivePrice: $effectivePrice, discountType: $discountType, discountValue: $discountValue, outletId: $outletId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotDealItemImpl &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.effectivePrice, effectivePrice) ||
                other.effectivePrice == effectivePrice) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.outletId, outletId) ||
                other.outletId == outletId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    brandId,
    brandName,
    productName,
    imageUrl,
    originalPrice,
    effectivePrice,
    discountType,
    discountValue,
    outletId,
  );

  /// Create a copy of HotDealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotDealItemImplCopyWith<_$HotDealItemImpl> get copyWith =>
      __$$HotDealItemImplCopyWithImpl<_$HotDealItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HotDealItemImplToJson(this);
  }
}

abstract class _HotDealItem implements HotDealItem {
  const factory _HotDealItem({
    @JsonKey(name: 'brand_id') required final String brandId,
    @JsonKey(name: 'brand_name') final String? brandName,
    @JsonKey(name: 'product_name') required final String productName,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'original_price') required final String originalPrice,
    @JsonKey(name: 'effective_price') required final String effectivePrice,
    @JsonKey(name: 'discount_type') required final String discountType,
    @JsonKey(name: 'discount_value') required final String discountValue,
    @JsonKey(name: 'outlet_id') final String? outletId,
  }) = _$HotDealItemImpl;

  factory _HotDealItem.fromJson(Map<String, dynamic> json) =
      _$HotDealItemImpl.fromJson;

  @override
  @JsonKey(name: 'brand_id')
  String get brandId;
  @override
  @JsonKey(name: 'brand_name')
  String? get brandName;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'original_price')
  String get originalPrice;
  @override
  @JsonKey(name: 'effective_price')
  String get effectivePrice;
  @override
  @JsonKey(name: 'discount_type')
  String get discountType;
  @override
  @JsonKey(name: 'discount_value')
  String get discountValue;
  @override
  @JsonKey(name: 'outlet_id')
  String? get outletId;

  /// Create a copy of HotDealItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotDealItemImplCopyWith<_$HotDealItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
