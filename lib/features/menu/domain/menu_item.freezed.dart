// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return _MenuItem.fromJson(json);
}

/// @nodoc
mixin _$MenuItem {
  /// Outlet-scoped product ID — maps to API field `id`.
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

  /// Serializes this MenuItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemCopyWith<MenuItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemCopyWith<$Res> {
  factory $MenuItemCopyWith(MenuItem value, $Res Function(MenuItem) then) =
      _$MenuItemCopyWithImpl<$Res, MenuItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String outletProductId,
    String name,
    String price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'stock_available') bool stockAvailable,
    @JsonKey(name: 'active_promotion') ActivePromotion? activePromotion,
  });

  $ActivePromotionCopyWith<$Res>? get activePromotion;
}

/// @nodoc
class _$MenuItemCopyWithImpl<$Res, $Val extends MenuItem>
    implements $MenuItemCopyWith<$Res> {
  _$MenuItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItem
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
          )
          as $Val,
    );
  }

  /// Create a copy of MenuItem
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
abstract class _$$MenuItemImplCopyWith<$Res>
    implements $MenuItemCopyWith<$Res> {
  factory _$$MenuItemImplCopyWith(
    _$MenuItemImpl value,
    $Res Function(_$MenuItemImpl) then,
  ) = __$$MenuItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String outletProductId,
    String name,
    String price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'stock_available') bool stockAvailable,
    @JsonKey(name: 'active_promotion') ActivePromotion? activePromotion,
  });

  @override
  $ActivePromotionCopyWith<$Res>? get activePromotion;
}

/// @nodoc
class __$$MenuItemImplCopyWithImpl<$Res>
    extends _$MenuItemCopyWithImpl<$Res, _$MenuItemImpl>
    implements _$$MenuItemImplCopyWith<$Res> {
  __$$MenuItemImplCopyWithImpl(
    _$MenuItemImpl _value,
    $Res Function(_$MenuItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuItem
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
  }) {
    return _then(
      _$MenuItemImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemImpl extends _MenuItem {
  const _$MenuItemImpl({
    @JsonKey(name: 'id') required this.outletProductId,
    required this.name,
    required this.price,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'stock_available') required this.stockAvailable,
    @JsonKey(name: 'active_promotion') this.activePromotion,
  }) : super._();

  factory _$MenuItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemImplFromJson(json);

  /// Outlet-scoped product ID — maps to API field `id`.
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
  String toString() {
    return 'MenuItem(outletProductId: $outletProductId, name: $name, price: $price, imageUrl: $imageUrl, stockAvailable: $stockAvailable, activePromotion: $activePromotion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemImpl &&
            (identical(other.outletProductId, outletProductId) ||
                other.outletProductId == outletProductId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.stockAvailable, stockAvailable) ||
                other.stockAvailable == stockAvailable) &&
            (identical(other.activePromotion, activePromotion) ||
                other.activePromotion == activePromotion));
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
  );

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      __$$MenuItemImplCopyWithImpl<_$MenuItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemImplToJson(this);
  }
}

abstract class _MenuItem extends MenuItem {
  const factory _MenuItem({
    @JsonKey(name: 'id') required final String outletProductId,
    required final String name,
    required final String price,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'stock_available') required final bool stockAvailable,
    @JsonKey(name: 'active_promotion') final ActivePromotion? activePromotion,
  }) = _$MenuItemImpl;
  const _MenuItem._() : super._();

  factory _MenuItem.fromJson(Map<String, dynamic> json) =
      _$MenuItemImpl.fromJson;

  /// Outlet-scoped product ID — maps to API field `id`.
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

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivePromotion _$ActivePromotionFromJson(Map<String, dynamic> json) {
  return _ActivePromotion.fromJson(json);
}

/// @nodoc
mixin _$ActivePromotion {
  @JsonKey(name: 'discount_type')
  String get discountType => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_value')
  String get discountValue => throw _privateConstructorUsedError;

  /// Serializes this ActivePromotion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivePromotion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivePromotionCopyWith<ActivePromotion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivePromotionCopyWith<$Res> {
  factory $ActivePromotionCopyWith(
    ActivePromotion value,
    $Res Function(ActivePromotion) then,
  ) = _$ActivePromotionCopyWithImpl<$Res, ActivePromotion>;
  @useResult
  $Res call({
    @JsonKey(name: 'discount_type') String discountType,
    @JsonKey(name: 'discount_value') String discountValue,
  });
}

/// @nodoc
class _$ActivePromotionCopyWithImpl<$Res, $Val extends ActivePromotion>
    implements $ActivePromotionCopyWith<$Res> {
  _$ActivePromotionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivePromotion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? discountType = null, Object? discountValue = null}) {
    return _then(
      _value.copyWith(
            discountType: null == discountType
                ? _value.discountType
                : discountType // ignore: cast_nullable_to_non_nullable
                      as String,
            discountValue: null == discountValue
                ? _value.discountValue
                : discountValue // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivePromotionImplCopyWith<$Res>
    implements $ActivePromotionCopyWith<$Res> {
  factory _$$ActivePromotionImplCopyWith(
    _$ActivePromotionImpl value,
    $Res Function(_$ActivePromotionImpl) then,
  ) = __$$ActivePromotionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'discount_type') String discountType,
    @JsonKey(name: 'discount_value') String discountValue,
  });
}

/// @nodoc
class __$$ActivePromotionImplCopyWithImpl<$Res>
    extends _$ActivePromotionCopyWithImpl<$Res, _$ActivePromotionImpl>
    implements _$$ActivePromotionImplCopyWith<$Res> {
  __$$ActivePromotionImplCopyWithImpl(
    _$ActivePromotionImpl _value,
    $Res Function(_$ActivePromotionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivePromotion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? discountType = null, Object? discountValue = null}) {
    return _then(
      _$ActivePromotionImpl(
        discountType: null == discountType
            ? _value.discountType
            : discountType // ignore: cast_nullable_to_non_nullable
                  as String,
        discountValue: null == discountValue
            ? _value.discountValue
            : discountValue // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivePromotionImpl implements _ActivePromotion {
  const _$ActivePromotionImpl({
    @JsonKey(name: 'discount_type') required this.discountType,
    @JsonKey(name: 'discount_value') required this.discountValue,
  });

  factory _$ActivePromotionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivePromotionImplFromJson(json);

  @override
  @JsonKey(name: 'discount_type')
  final String discountType;
  @override
  @JsonKey(name: 'discount_value')
  final String discountValue;

  @override
  String toString() {
    return 'ActivePromotion(discountType: $discountType, discountValue: $discountValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivePromotionImpl &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, discountType, discountValue);

  /// Create a copy of ActivePromotion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivePromotionImplCopyWith<_$ActivePromotionImpl> get copyWith =>
      __$$ActivePromotionImplCopyWithImpl<_$ActivePromotionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivePromotionImplToJson(this);
  }
}

abstract class _ActivePromotion implements ActivePromotion {
  const factory _ActivePromotion({
    @JsonKey(name: 'discount_type') required final String discountType,
    @JsonKey(name: 'discount_value') required final String discountValue,
  }) = _$ActivePromotionImpl;

  factory _ActivePromotion.fromJson(Map<String, dynamic> json) =
      _$ActivePromotionImpl.fromJson;

  @override
  @JsonKey(name: 'discount_type')
  String get discountType;
  @override
  @JsonKey(name: 'discount_value')
  String get discountValue;

  /// Create a copy of ActivePromotion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivePromotionImplCopyWith<_$ActivePromotionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) {
  return _MenuCategory.fromJson(json);
}

/// @nodoc
mixin _$MenuCategory {
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  List<MenuItem> get items => throw _privateConstructorUsedError;

  /// Serializes this MenuCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuCategoryCopyWith<MenuCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuCategoryCopyWith<$Res> {
  factory $MenuCategoryCopyWith(
    MenuCategory value,
    $Res Function(MenuCategory) then,
  ) = _$MenuCategoryCopyWithImpl<$Res, MenuCategory>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    List<MenuItem> items,
  });
}

/// @nodoc
class _$MenuCategoryCopyWithImpl<$Res, $Val extends MenuCategory>
    implements $MenuCategoryCopyWith<$Res> {
  _$MenuCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<MenuItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuCategoryImplCopyWith<$Res>
    implements $MenuCategoryCopyWith<$Res> {
  factory _$$MenuCategoryImplCopyWith(
    _$MenuCategoryImpl value,
    $Res Function(_$MenuCategoryImpl) then,
  ) = __$$MenuCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    List<MenuItem> items,
  });
}

/// @nodoc
class __$$MenuCategoryImplCopyWithImpl<$Res>
    extends _$MenuCategoryCopyWithImpl<$Res, _$MenuCategoryImpl>
    implements _$$MenuCategoryImplCopyWith<$Res> {
  __$$MenuCategoryImplCopyWithImpl(
    _$MenuCategoryImpl _value,
    $Res Function(_$MenuCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? items = null,
  }) {
    return _then(
      _$MenuCategoryImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<MenuItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuCategoryImpl implements _MenuCategory {
  const _$MenuCategoryImpl({
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') required this.categoryName,
    required final List<MenuItem> items,
  }) : _items = items;

  factory _$MenuCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  final List<MenuItem> _items;
  @override
  List<MenuItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'MenuCategory(categoryId: $categoryId, categoryName: $categoryName, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuCategoryImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    categoryName,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuCategoryImplCopyWith<_$MenuCategoryImpl> get copyWith =>
      __$$MenuCategoryImplCopyWithImpl<_$MenuCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuCategoryImplToJson(this);
  }
}

abstract class _MenuCategory implements MenuCategory {
  const factory _MenuCategory({
    @JsonKey(name: 'category_id') required final String categoryId,
    @JsonKey(name: 'category_name') required final String categoryName,
    required final List<MenuItem> items,
  }) = _$MenuCategoryImpl;

  factory _MenuCategory.fromJson(Map<String, dynamic> json) =
      _$MenuCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  List<MenuItem> get items;

  /// Create a copy of MenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuCategoryImplCopyWith<_$MenuCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
