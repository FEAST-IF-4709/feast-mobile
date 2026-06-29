// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_tracking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrackingOrderItem {
  String get productName => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get unitPrice => throw _privateConstructorUsedError;
  String get lineTotal => throw _privateConstructorUsedError;
  String? get itemNotes => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of TrackingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackingOrderItemCopyWith<TrackingOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingOrderItemCopyWith<$Res> {
  factory $TrackingOrderItemCopyWith(
    TrackingOrderItem value,
    $Res Function(TrackingOrderItem) then,
  ) = _$TrackingOrderItemCopyWithImpl<$Res, TrackingOrderItem>;
  @useResult
  $Res call({
    String productName,
    int quantity,
    String unitPrice,
    String lineTotal,
    String? itemNotes,
    String? imageUrl,
  });
}

/// @nodoc
class _$TrackingOrderItemCopyWithImpl<$Res, $Val extends TrackingOrderItem>
    implements $TrackingOrderItemCopyWith<$Res> {
  _$TrackingOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
    Object? itemNotes = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$TrackingOrderItemImplCopyWith<$Res>
    implements $TrackingOrderItemCopyWith<$Res> {
  factory _$$TrackingOrderItemImplCopyWith(
    _$TrackingOrderItemImpl value,
    $Res Function(_$TrackingOrderItemImpl) then,
  ) = __$$TrackingOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productName,
    int quantity,
    String unitPrice,
    String lineTotal,
    String? itemNotes,
    String? imageUrl,
  });
}

/// @nodoc
class __$$TrackingOrderItemImplCopyWithImpl<$Res>
    extends _$TrackingOrderItemCopyWithImpl<$Res, _$TrackingOrderItemImpl>
    implements _$$TrackingOrderItemImplCopyWith<$Res> {
  __$$TrackingOrderItemImplCopyWithImpl(
    _$TrackingOrderItemImpl _value,
    $Res Function(_$TrackingOrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrackingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
    Object? itemNotes = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$TrackingOrderItemImpl(
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
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
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TrackingOrderItemImpl implements _TrackingOrderItem {
  const _$TrackingOrderItemImpl({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
    this.itemNotes,
    this.imageUrl,
  });

  @override
  final String productName;
  @override
  final int quantity;
  @override
  final String unitPrice;
  @override
  final String lineTotal;
  @override
  final String? itemNotes;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'TrackingOrderItem(productName: $productName, quantity: $quantity, unitPrice: $unitPrice, lineTotal: $lineTotal, itemNotes: $itemNotes, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingOrderItemImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal) &&
            (identical(other.itemNotes, itemNotes) ||
                other.itemNotes == itemNotes) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    productName,
    quantity,
    unitPrice,
    lineTotal,
    itemNotes,
    imageUrl,
  );

  /// Create a copy of TrackingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingOrderItemImplCopyWith<_$TrackingOrderItemImpl> get copyWith =>
      __$$TrackingOrderItemImplCopyWithImpl<_$TrackingOrderItemImpl>(
        this,
        _$identity,
      );
}

abstract class _TrackingOrderItem implements TrackingOrderItem {
  const factory _TrackingOrderItem({
    required final String productName,
    required final int quantity,
    required final String unitPrice,
    required final String lineTotal,
    final String? itemNotes,
    final String? imageUrl,
  }) = _$TrackingOrderItemImpl;

  @override
  String get productName;
  @override
  int get quantity;
  @override
  String get unitPrice;
  @override
  String get lineTotal;
  @override
  String? get itemNotes;
  @override
  String? get imageUrl;

  /// Create a copy of TrackingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackingOrderItemImplCopyWith<_$TrackingOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderTrackingState {
  FulfillmentStatus get fulfillmentStatus => throw _privateConstructorUsedError;
  bool get paymentSettled => throw _privateConstructorUsedError;
  bool get isReconnecting => throw _privateConstructorUsedError;
  List<TrackingOrderItem> get orderItems => throw _privateConstructorUsedError;
  String? get orderNumber => throw _privateConstructorUsedError;
  String? get subtotal => throw _privateConstructorUsedError;
  String? get taxAmount => throw _privateConstructorUsedError;
  String? get grandTotal => throw _privateConstructorUsedError;
  String? get orderNotes => throw _privateConstructorUsedError;

  /// Create a copy of OrderTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderTrackingStateCopyWith<OrderTrackingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTrackingStateCopyWith<$Res> {
  factory $OrderTrackingStateCopyWith(
    OrderTrackingState value,
    $Res Function(OrderTrackingState) then,
  ) = _$OrderTrackingStateCopyWithImpl<$Res, OrderTrackingState>;
  @useResult
  $Res call({
    FulfillmentStatus fulfillmentStatus,
    bool paymentSettled,
    bool isReconnecting,
    List<TrackingOrderItem> orderItems,
    String? orderNumber,
    String? subtotal,
    String? taxAmount,
    String? grandTotal,
    String? orderNotes,
  });
}

/// @nodoc
class _$OrderTrackingStateCopyWithImpl<$Res, $Val extends OrderTrackingState>
    implements $OrderTrackingStateCopyWith<$Res> {
  _$OrderTrackingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fulfillmentStatus = null,
    Object? paymentSettled = null,
    Object? isReconnecting = null,
    Object? orderItems = null,
    Object? orderNumber = freezed,
    Object? subtotal = freezed,
    Object? taxAmount = freezed,
    Object? grandTotal = freezed,
    Object? orderNotes = freezed,
  }) {
    return _then(
      _value.copyWith(
            fulfillmentStatus: null == fulfillmentStatus
                ? _value.fulfillmentStatus
                : fulfillmentStatus // ignore: cast_nullable_to_non_nullable
                      as FulfillmentStatus,
            paymentSettled: null == paymentSettled
                ? _value.paymentSettled
                : paymentSettled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isReconnecting: null == isReconnecting
                ? _value.isReconnecting
                : isReconnecting // ignore: cast_nullable_to_non_nullable
                      as bool,
            orderItems: null == orderItems
                ? _value.orderItems
                : orderItems // ignore: cast_nullable_to_non_nullable
                      as List<TrackingOrderItem>,
            orderNumber: freezed == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            subtotal: freezed == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxAmount: freezed == taxAmount
                ? _value.taxAmount
                : taxAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            grandTotal: freezed == grandTotal
                ? _value.grandTotal
                : grandTotal // ignore: cast_nullable_to_non_nullable
                      as String?,
            orderNotes: freezed == orderNotes
                ? _value.orderNotes
                : orderNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderTrackingStateImplCopyWith<$Res>
    implements $OrderTrackingStateCopyWith<$Res> {
  factory _$$OrderTrackingStateImplCopyWith(
    _$OrderTrackingStateImpl value,
    $Res Function(_$OrderTrackingStateImpl) then,
  ) = __$$OrderTrackingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    FulfillmentStatus fulfillmentStatus,
    bool paymentSettled,
    bool isReconnecting,
    List<TrackingOrderItem> orderItems,
    String? orderNumber,
    String? subtotal,
    String? taxAmount,
    String? grandTotal,
    String? orderNotes,
  });
}

/// @nodoc
class __$$OrderTrackingStateImplCopyWithImpl<$Res>
    extends _$OrderTrackingStateCopyWithImpl<$Res, _$OrderTrackingStateImpl>
    implements _$$OrderTrackingStateImplCopyWith<$Res> {
  __$$OrderTrackingStateImplCopyWithImpl(
    _$OrderTrackingStateImpl _value,
    $Res Function(_$OrderTrackingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fulfillmentStatus = null,
    Object? paymentSettled = null,
    Object? isReconnecting = null,
    Object? orderItems = null,
    Object? orderNumber = freezed,
    Object? subtotal = freezed,
    Object? taxAmount = freezed,
    Object? grandTotal = freezed,
    Object? orderNotes = freezed,
  }) {
    return _then(
      _$OrderTrackingStateImpl(
        fulfillmentStatus: null == fulfillmentStatus
            ? _value.fulfillmentStatus
            : fulfillmentStatus // ignore: cast_nullable_to_non_nullable
                  as FulfillmentStatus,
        paymentSettled: null == paymentSettled
            ? _value.paymentSettled
            : paymentSettled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isReconnecting: null == isReconnecting
            ? _value.isReconnecting
            : isReconnecting // ignore: cast_nullable_to_non_nullable
                  as bool,
        orderItems: null == orderItems
            ? _value._orderItems
            : orderItems // ignore: cast_nullable_to_non_nullable
                  as List<TrackingOrderItem>,
        orderNumber: freezed == orderNumber
            ? _value.orderNumber
            : orderNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        subtotal: freezed == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxAmount: freezed == taxAmount
            ? _value.taxAmount
            : taxAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        grandTotal: freezed == grandTotal
            ? _value.grandTotal
            : grandTotal // ignore: cast_nullable_to_non_nullable
                  as String?,
        orderNotes: freezed == orderNotes
            ? _value.orderNotes
            : orderNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderTrackingStateImpl implements _OrderTrackingState {
  const _$OrderTrackingStateImpl({
    required this.fulfillmentStatus,
    this.paymentSettled = false,
    this.isReconnecting = false,
    final List<TrackingOrderItem> orderItems = const [],
    this.orderNumber,
    this.subtotal,
    this.taxAmount,
    this.grandTotal,
    this.orderNotes,
  }) : _orderItems = orderItems;

  @override
  final FulfillmentStatus fulfillmentStatus;
  @override
  @JsonKey()
  final bool paymentSettled;
  @override
  @JsonKey()
  final bool isReconnecting;
  final List<TrackingOrderItem> _orderItems;
  @override
  @JsonKey()
  List<TrackingOrderItem> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  @override
  final String? orderNumber;
  @override
  final String? subtotal;
  @override
  final String? taxAmount;
  @override
  final String? grandTotal;
  @override
  final String? orderNotes;

  @override
  String toString() {
    return 'OrderTrackingState(fulfillmentStatus: $fulfillmentStatus, paymentSettled: $paymentSettled, isReconnecting: $isReconnecting, orderItems: $orderItems, orderNumber: $orderNumber, subtotal: $subtotal, taxAmount: $taxAmount, grandTotal: $grandTotal, orderNotes: $orderNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTrackingStateImpl &&
            (identical(other.fulfillmentStatus, fulfillmentStatus) ||
                other.fulfillmentStatus == fulfillmentStatus) &&
            (identical(other.paymentSettled, paymentSettled) ||
                other.paymentSettled == paymentSettled) &&
            (identical(other.isReconnecting, isReconnecting) ||
                other.isReconnecting == isReconnecting) &&
            const DeepCollectionEquality().equals(
              other._orderItems,
              _orderItems,
            ) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.orderNotes, orderNotes) ||
                other.orderNotes == orderNotes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    fulfillmentStatus,
    paymentSettled,
    isReconnecting,
    const DeepCollectionEquality().hash(_orderItems),
    orderNumber,
    subtotal,
    taxAmount,
    grandTotal,
    orderNotes,
  );

  /// Create a copy of OrderTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderTrackingStateImplCopyWith<_$OrderTrackingStateImpl> get copyWith =>
      __$$OrderTrackingStateImplCopyWithImpl<_$OrderTrackingStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OrderTrackingState implements OrderTrackingState {
  const factory _OrderTrackingState({
    required final FulfillmentStatus fulfillmentStatus,
    final bool paymentSettled,
    final bool isReconnecting,
    final List<TrackingOrderItem> orderItems,
    final String? orderNumber,
    final String? subtotal,
    final String? taxAmount,
    final String? grandTotal,
    final String? orderNotes,
  }) = _$OrderTrackingStateImpl;

  @override
  FulfillmentStatus get fulfillmentStatus;
  @override
  bool get paymentSettled;
  @override
  bool get isReconnecting;
  @override
  List<TrackingOrderItem> get orderItems;
  @override
  String? get orderNumber;
  @override
  String? get subtotal;
  @override
  String? get taxAmount;
  @override
  String? get grandTotal;
  @override
  String? get orderNotes;

  /// Create a copy of OrderTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderTrackingStateImplCopyWith<_$OrderTrackingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
