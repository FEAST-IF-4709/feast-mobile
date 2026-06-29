// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PopularItem _$PopularItemFromJson(Map<String, dynamic> json) {
  return _PopularItem.fromJson(json);
}

/// @nodoc
mixin _$PopularItem {
  @JsonKey(name: 'id')
  String get outletProductId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_available')
  bool get stockAvailable => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_promotion')
  ActivePromotion? get activePromotion => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_qty_sold')
  int get totalQtySold => throw _privateConstructorUsedError;

  /// Serializes this PopularItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PopularItemCopyWith<PopularItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularItemCopyWith<$Res> {
  factory $PopularItemCopyWith(
    PopularItem value,
    $Res Function(PopularItem) then,
  ) = _$PopularItemCopyWithImpl<$Res, PopularItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String outletProductId,
    String name,
    String price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'stock_available') bool stockAvailable,
    @JsonKey(name: 'active_promotion') ActivePromotion? activePromotion,
    @JsonKey(name: 'total_qty_sold') int totalQtySold,
  });

  $ActivePromotionCopyWith<$Res>? get activePromotion;
}

/// @nodoc
class _$PopularItemCopyWithImpl<$Res, $Val extends PopularItem>
    implements $PopularItemCopyWith<$Res> {
  _$PopularItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outletProductId = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? stockAvailable = null,
    Object? activePromotion = freezed,
    Object? totalQtySold = null,
  }) {
    return _then(
      _value.copyWith(
            outletProductId: null == outletProductId
                ? _value.outletProductId
                : outletProductId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            stockAvailable: null == stockAvailable
                ? _value.stockAvailable
                : stockAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            activePromotion: freezed == activePromotion
                ? _value.activePromotion
                : activePromotion // ignore: cast_nullable_to_non_nullable
                      as ActivePromotion?,
            totalQtySold: null == totalQtySold
                ? _value.totalQtySold
                : totalQtySold // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivePromotionCopyWith<$Res>? get activePromotion {
    if (_value.activePromotion == null) {
      return null;
    }

    return $ActivePromotionCopyWith<$Res>(_value.activePromotion!, (value) {
      return _then(_value.copyWith(activePromotion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PopularItemImplCopyWith<$Res>
    implements $PopularItemCopyWith<$Res> {
  factory _$$PopularItemImplCopyWith(
    _$PopularItemImpl value,
    $Res Function(_$PopularItemImpl) then,
  ) = __$$PopularItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String outletProductId,
    String name,
    String price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'stock_available') bool stockAvailable,
    @JsonKey(name: 'active_promotion') ActivePromotion? activePromotion,
    @JsonKey(name: 'total_qty_sold') int totalQtySold,
  });

  @override
  $ActivePromotionCopyWith<$Res>? get activePromotion;
}

/// @nodoc
class __$$PopularItemImplCopyWithImpl<$Res>
    extends _$PopularItemCopyWithImpl<$Res, _$PopularItemImpl>
    implements _$$PopularItemImplCopyWith<$Res> {
  __$$PopularItemImplCopyWithImpl(
    _$PopularItemImpl _value,
    $Res Function(_$PopularItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outletProductId = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? stockAvailable = null,
    Object? activePromotion = freezed,
    Object? totalQtySold = null,
  }) {
    return _then(
      _$PopularItemImpl(
        outletProductId: null == outletProductId
            ? _value.outletProductId
            : outletProductId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        stockAvailable: null == stockAvailable
            ? _value.stockAvailable
            : stockAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        activePromotion: freezed == activePromotion
            ? _value.activePromotion
            : activePromotion // ignore: cast_nullable_to_non_nullable
                  as ActivePromotion?,
        totalQtySold: null == totalQtySold
            ? _value.totalQtySold
            : totalQtySold // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PopularItemImpl extends _PopularItem {
  const _$PopularItemImpl({
    @JsonKey(name: 'id') required this.outletProductId,
    required this.name,
    required this.price,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'stock_available') required this.stockAvailable,
    @JsonKey(name: 'active_promotion') this.activePromotion,
    @JsonKey(name: 'total_qty_sold') required this.totalQtySold,
  }) : super._();

  factory _$PopularItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PopularItemImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String outletProductId;
  @override
  final String name;
  @override
  final String price;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'stock_available')
  final bool stockAvailable;
  @override
  @JsonKey(name: 'active_promotion')
  final ActivePromotion? activePromotion;
  @override
  @JsonKey(name: 'total_qty_sold')
  final int totalQtySold;

  @override
  String toString() {
    return 'PopularItem(outletProductId: $outletProductId, name: $name, price: $price, imageUrl: $imageUrl, stockAvailable: $stockAvailable, activePromotion: $activePromotion, totalQtySold: $totalQtySold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularItemImpl &&
            (identical(other.outletProductId, outletProductId) ||
                other.outletProductId == outletProductId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.stockAvailable, stockAvailable) ||
                other.stockAvailable == stockAvailable) &&
            (identical(other.activePromotion, activePromotion) ||
                other.activePromotion == activePromotion) &&
            (identical(other.totalQtySold, totalQtySold) ||
                other.totalQtySold == totalQtySold));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    outletProductId,
    name,
    price,
    imageUrl,
    stockAvailable,
    activePromotion,
    totalQtySold,
  );

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularItemImplCopyWith<_$PopularItemImpl> get copyWith =>
      __$$PopularItemImplCopyWithImpl<_$PopularItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PopularItemImplToJson(this);
  }
}

abstract class _PopularItem extends PopularItem {
  const factory _PopularItem({
    @JsonKey(name: 'id') required final String outletProductId,
    required final String name,
    required final String price,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'stock_available') required final bool stockAvailable,
    @JsonKey(name: 'active_promotion') final ActivePromotion? activePromotion,
    @JsonKey(name: 'total_qty_sold') required final int totalQtySold,
  }) = _$PopularItemImpl;
  const _PopularItem._() : super._();

  factory _PopularItem.fromJson(Map<String, dynamic> json) =
      _$PopularItemImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get outletProductId;
  @override
  String get name;
  @override
  String get price;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'stock_available')
  bool get stockAvailable;
  @override
  @JsonKey(name: 'active_promotion')
  ActivePromotion? get activePromotion;
  @override
  @JsonKey(name: 'total_qty_sold')
  int get totalQtySold;

  /// Create a copy of PopularItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularItemImplCopyWith<_$PopularItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
