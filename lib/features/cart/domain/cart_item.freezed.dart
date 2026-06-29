// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CartItem {
  String get outletProductId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get effectivePrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get itemNotes => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call({
    String outletProductId,
    String name,
    String effectivePrice,
    int quantity,
    String? itemNotes,
    String? imageUrl,
  });
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outletProductId = null,
    Object? name = null,
    Object? effectivePrice = null,
    Object? quantity = null,
    Object? itemNotes = freezed,
    Object? imageUrl = freezed,
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
            effectivePrice: null == effectivePrice
                ? _value.effectivePrice
                : effectivePrice // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            itemNotes: freezed == itemNotes
                ? _value.itemNotes
                : itemNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
    _$CartItemImpl value,
    $Res Function(_$CartItemImpl) then,
  ) = __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String outletProductId,
    String name,
    String effectivePrice,
    int quantity,
    String? itemNotes,
    String? imageUrl,
  });
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
    _$CartItemImpl _value,
    $Res Function(_$CartItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outletProductId = null,
    Object? name = null,
    Object? effectivePrice = null,
    Object? quantity = null,
    Object? itemNotes = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$CartItemImpl(
        outletProductId: null == outletProductId
            ? _value.outletProductId
            : outletProductId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        effectivePrice: null == effectivePrice
            ? _value.effectivePrice
            : effectivePrice // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        itemNotes: freezed == itemNotes
            ? _value.itemNotes
            : itemNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CartItemImpl implements _CartItem {
  const _$CartItemImpl({
    required this.outletProductId,
    required this.name,
    required this.effectivePrice,
    required this.quantity,
    this.itemNotes,
    this.imageUrl,
  });

  @override
  final String outletProductId;
  @override
  final String name;
  @override
  final String effectivePrice;
  @override
  final int quantity;
  @override
  final String? itemNotes;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'CartItem(outletProductId: $outletProductId, name: $name, effectivePrice: $effectivePrice, quantity: $quantity, itemNotes: $itemNotes, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.outletProductId, outletProductId) ||
                other.outletProductId == outletProductId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.effectivePrice, effectivePrice) ||
                other.effectivePrice == effectivePrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.itemNotes, itemNotes) ||
                other.itemNotes == itemNotes) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    outletProductId,
    name,
    effectivePrice,
    quantity,
    itemNotes,
    imageUrl,
  );

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);
}

abstract class _CartItem implements CartItem {
  const factory _CartItem({
    required final String outletProductId,
    required final String name,
    required final String effectivePrice,
    required final int quantity,
    final String? itemNotes,
    final String? imageUrl,
  }) = _$CartItemImpl;

  @override
  String get outletProductId;
  @override
  String get name;
  @override
  String get effectivePrice;
  @override
  int get quantity;
  @override
  String? get itemNotes;
  @override
  String? get imageUrl;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
