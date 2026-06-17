// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderDetailItem _$OrderDetailItemFromJson(Map<String, dynamic> json) {
  return _OrderDetailItem.fromJson(json);
}

/// @nodoc
mixin _$OrderDetailItem {
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  String get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_total')
  String get lineTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_notes')
  String? get itemNotes => throw _privateConstructorUsedError;

  /// Serializes this OrderDetailItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDetailItemCopyWith<OrderDetailItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailItemCopyWith<$Res> {
  factory $OrderDetailItemCopyWith(
    OrderDetailItem value,
    $Res Function(OrderDetailItem) then,
  ) = _$OrderDetailItemCopyWithImpl<$Res, OrderDetailItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'product_name') String? productName,
    int quantity,
    @JsonKey(name: 'unit_price') String unitPrice,
    @JsonKey(name: 'line_total') String lineTotal,
    @JsonKey(name: 'item_notes') String? itemNotes,
  });
}

/// @nodoc
class _$OrderDetailItemCopyWithImpl<$Res, $Val extends OrderDetailItem>
    implements $OrderDetailItemCopyWith<$Res> {
  _$OrderDetailItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
    Object? itemNotes = freezed,
  }) {
    return _then(
      _value.copyWith(
            productName: freezed == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as String,
            lineTotal: null == lineTotal
                ? _value.lineTotal
                : lineTotal // ignore: cast_nullable_to_non_nullable
                      as String,
            itemNotes: freezed == itemNotes
                ? _value.itemNotes
                : itemNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderDetailItemImplCopyWith<$Res>
    implements $OrderDetailItemCopyWith<$Res> {
  factory _$$OrderDetailItemImplCopyWith(
    _$OrderDetailItemImpl value,
    $Res Function(_$OrderDetailItemImpl) then,
  ) = __$$OrderDetailItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'product_name') String? productName,
    int quantity,
    @JsonKey(name: 'unit_price') String unitPrice,
    @JsonKey(name: 'line_total') String lineTotal,
    @JsonKey(name: 'item_notes') String? itemNotes,
  });
}

/// @nodoc
class __$$OrderDetailItemImplCopyWithImpl<$Res>
    extends _$OrderDetailItemCopyWithImpl<$Res, _$OrderDetailItemImpl>
    implements _$$OrderDetailItemImplCopyWith<$Res> {
  __$$OrderDetailItemImplCopyWithImpl(
    _$OrderDetailItemImpl _value,
    $Res Function(_$OrderDetailItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
    Object? itemNotes = freezed,
  }) {
    return _then(
      _$OrderDetailItemImpl(
        productName: freezed == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as String,
        lineTotal: null == lineTotal
            ? _value.lineTotal
            : lineTotal // ignore: cast_nullable_to_non_nullable
                  as String,
        itemNotes: freezed == itemNotes
            ? _value.itemNotes
            : itemNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDetailItemImpl implements _OrderDetailItem {
  const _$OrderDetailItemImpl({
    @JsonKey(name: 'product_name') this.productName,
    required this.quantity,
    @JsonKey(name: 'unit_price') required this.unitPrice,
    @JsonKey(name: 'line_total') required this.lineTotal,
    @JsonKey(name: 'item_notes') this.itemNotes,
  });

  factory _$OrderDetailItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDetailItemImplFromJson(json);

  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'unit_price')
  final String unitPrice;
  @override
  @JsonKey(name: 'line_total')
  final String lineTotal;
  @override
  @JsonKey(name: 'item_notes')
  final String? itemNotes;

  @override
  String toString() {
    return 'OrderDetailItem(productName: $productName, quantity: $quantity, unitPrice: $unitPrice, lineTotal: $lineTotal, itemNotes: $itemNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailItemImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal) &&
            (identical(other.itemNotes, itemNotes) ||
                other.itemNotes == itemNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productName,
    quantity,
    unitPrice,
    lineTotal,
    itemNotes,
  );

  /// Create a copy of OrderDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDetailItemImplCopyWith<_$OrderDetailItemImpl> get copyWith =>
      __$$OrderDetailItemImplCopyWithImpl<_$OrderDetailItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDetailItemImplToJson(this);
  }
}

abstract class _OrderDetailItem implements OrderDetailItem {
  const factory _OrderDetailItem({
    @JsonKey(name: 'product_name') final String? productName,
    required final int quantity,
    @JsonKey(name: 'unit_price') required final String unitPrice,
    @JsonKey(name: 'line_total') required final String lineTotal,
    @JsonKey(name: 'item_notes') final String? itemNotes,
  }) = _$OrderDetailItemImpl;

  factory _OrderDetailItem.fromJson(Map<String, dynamic> json) =
      _$OrderDetailItemImpl.fromJson;

  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'unit_price')
  String get unitPrice;
  @override
  @JsonKey(name: 'line_total')
  String get lineTotal;
  @override
  @JsonKey(name: 'item_notes')
  String? get itemNotes;

  /// Create a copy of OrderDetailItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDetailItemImplCopyWith<_$OrderDetailItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return _OrderDetail.fromJson(json);
}

/// @nodoc
mixin _$OrderDetail {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_number')
  String get orderNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'outlet_name')
  String get outletName => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_name')
  String? get brandName => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  String? get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  String get grandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'fulfillment_status')
  String get fulfillmentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'placed_at')
  DateTime get placedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<OrderDetailItem> get items => throw _privateConstructorUsedError;

  /// Serializes this OrderDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDetailCopyWith<OrderDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailCopyWith<$Res> {
  factory $OrderDetailCopyWith(
    OrderDetail value,
    $Res Function(OrderDetail) then,
  ) = _$OrderDetailCopyWithImpl<$Res, OrderDetail>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_number') String orderNumber,
    @JsonKey(name: 'outlet_name') String outletName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'tax_amount') String? taxAmount,
    @JsonKey(name: 'grand_total') String grandTotal,
    @JsonKey(name: 'fulfillment_status') String fulfillmentStatus,
    @JsonKey(name: 'placed_at') DateTime placedAt,
    String? notes,
    List<OrderDetailItem> items,
  });
}

/// @nodoc
class _$OrderDetailCopyWithImpl<$Res, $Val extends OrderDetail>
    implements $OrderDetailCopyWith<$Res> {
  _$OrderDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? outletName = null,
    Object? brandName = freezed,
    Object? taxAmount = freezed,
    Object? grandTotal = null,
    Object? fulfillmentStatus = null,
    Object? placedAt = null,
    Object? notes = freezed,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            orderNumber: null == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            outletName: null == outletName
                ? _value.outletName
                : outletName // ignore: cast_nullable_to_non_nullable
                      as String,
            brandName: freezed == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxAmount: freezed == taxAmount
                ? _value.taxAmount
                : taxAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            grandTotal: null == grandTotal
                ? _value.grandTotal
                : grandTotal // ignore: cast_nullable_to_non_nullable
                      as String,
            fulfillmentStatus: null == fulfillmentStatus
                ? _value.fulfillmentStatus
                : fulfillmentStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            placedAt: null == placedAt
                ? _value.placedAt
                : placedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<OrderDetailItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderDetailImplCopyWith<$Res>
    implements $OrderDetailCopyWith<$Res> {
  factory _$$OrderDetailImplCopyWith(
    _$OrderDetailImpl value,
    $Res Function(_$OrderDetailImpl) then,
  ) = __$$OrderDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_number') String orderNumber,
    @JsonKey(name: 'outlet_name') String outletName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'tax_amount') String? taxAmount,
    @JsonKey(name: 'grand_total') String grandTotal,
    @JsonKey(name: 'fulfillment_status') String fulfillmentStatus,
    @JsonKey(name: 'placed_at') DateTime placedAt,
    String? notes,
    List<OrderDetailItem> items,
  });
}

/// @nodoc
class __$$OrderDetailImplCopyWithImpl<$Res>
    extends _$OrderDetailCopyWithImpl<$Res, _$OrderDetailImpl>
    implements _$$OrderDetailImplCopyWith<$Res> {
  __$$OrderDetailImplCopyWithImpl(
    _$OrderDetailImpl _value,
    $Res Function(_$OrderDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? outletName = null,
    Object? brandName = freezed,
    Object? taxAmount = freezed,
    Object? grandTotal = null,
    Object? fulfillmentStatus = null,
    Object? placedAt = null,
    Object? notes = freezed,
    Object? items = null,
  }) {
    return _then(
      _$OrderDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        orderNumber: null == orderNumber
            ? _value.orderNumber
            : orderNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        outletName: null == outletName
            ? _value.outletName
            : outletName // ignore: cast_nullable_to_non_nullable
                  as String,
        brandName: freezed == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxAmount: freezed == taxAmount
            ? _value.taxAmount
            : taxAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        grandTotal: null == grandTotal
            ? _value.grandTotal
            : grandTotal // ignore: cast_nullable_to_non_nullable
                  as String,
        fulfillmentStatus: null == fulfillmentStatus
            ? _value.fulfillmentStatus
            : fulfillmentStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        placedAt: null == placedAt
            ? _value.placedAt
            : placedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<OrderDetailItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDetailImpl implements _OrderDetail {
  const _$OrderDetailImpl({
    required this.id,
    @JsonKey(name: 'order_number') required this.orderNumber,
    @JsonKey(name: 'outlet_name') this.outletName = '',
    @JsonKey(name: 'brand_name') this.brandName,
    @JsonKey(name: 'tax_amount') this.taxAmount,
    @JsonKey(name: 'grand_total') required this.grandTotal,
    @JsonKey(name: 'fulfillment_status') required this.fulfillmentStatus,
    @JsonKey(name: 'placed_at') required this.placedAt,
    this.notes,
    final List<OrderDetailItem> items = const [],
  }) : _items = items;

  factory _$OrderDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDetailImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'order_number')
  final String orderNumber;
  @override
  @JsonKey(name: 'outlet_name')
  final String outletName;
  @override
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @override
  @JsonKey(name: 'tax_amount')
  final String? taxAmount;
  @override
  @JsonKey(name: 'grand_total')
  final String grandTotal;
  @override
  @JsonKey(name: 'fulfillment_status')
  final String fulfillmentStatus;
  @override
  @JsonKey(name: 'placed_at')
  final DateTime placedAt;
  @override
  final String? notes;
  final List<OrderDetailItem> _items;
  @override
  @JsonKey()
  List<OrderDetailItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'OrderDetail(id: $id, orderNumber: $orderNumber, outletName: $outletName, brandName: $brandName, taxAmount: $taxAmount, grandTotal: $grandTotal, fulfillmentStatus: $fulfillmentStatus, placedAt: $placedAt, notes: $notes, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.outletName, outletName) ||
                other.outletName == outletName) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.fulfillmentStatus, fulfillmentStatus) ||
                other.fulfillmentStatus == fulfillmentStatus) &&
            (identical(other.placedAt, placedAt) ||
                other.placedAt == placedAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderNumber,
    outletName,
    brandName,
    taxAmount,
    grandTotal,
    fulfillmentStatus,
    placedAt,
    notes,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of OrderDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDetailImplCopyWith<_$OrderDetailImpl> get copyWith =>
      __$$OrderDetailImplCopyWithImpl<_$OrderDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDetailImplToJson(this);
  }
}

abstract class _OrderDetail implements OrderDetail {
  const factory _OrderDetail({
    required final String id,
    @JsonKey(name: 'order_number') required final String orderNumber,
    @JsonKey(name: 'outlet_name') final String outletName,
    @JsonKey(name: 'brand_name') final String? brandName,
    @JsonKey(name: 'tax_amount') final String? taxAmount,
    @JsonKey(name: 'grand_total') required final String grandTotal,
    @JsonKey(name: 'fulfillment_status')
    required final String fulfillmentStatus,
    @JsonKey(name: 'placed_at') required final DateTime placedAt,
    final String? notes,
    final List<OrderDetailItem> items,
  }) = _$OrderDetailImpl;

  factory _OrderDetail.fromJson(Map<String, dynamic> json) =
      _$OrderDetailImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'order_number')
  String get orderNumber;
  @override
  @JsonKey(name: 'outlet_name')
  String get outletName;
  @override
  @JsonKey(name: 'brand_name')
  String? get brandName;
  @override
  @JsonKey(name: 'tax_amount')
  String? get taxAmount;
  @override
  @JsonKey(name: 'grand_total')
  String get grandTotal;
  @override
  @JsonKey(name: 'fulfillment_status')
  String get fulfillmentStatus;
  @override
  @JsonKey(name: 'placed_at')
  DateTime get placedAt;
  @override
  String? get notes;
  @override
  List<OrderDetailItem> get items;

  /// Create a copy of OrderDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDetailImplCopyWith<_$OrderDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
