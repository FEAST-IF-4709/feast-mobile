// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderSummary _$OrderSummaryFromJson(Map<String, dynamic> json) {
  return _OrderSummary.fromJson(json);
}

/// @nodoc
mixin _$OrderSummary {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_number')
  String get orderNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'outlet_name')
  String get outletName => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_name')
  String? get brandName => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  String get grandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'fulfillment_status')
  String get fulfillmentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'placed_at')
  DateTime get placedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_count')
  int get itemCount => throw _privateConstructorUsedError;

  /// Serializes this OrderSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderSummaryCopyWith<OrderSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderSummaryCopyWith<$Res> {
  factory $OrderSummaryCopyWith(
    OrderSummary value,
    $Res Function(OrderSummary) then,
  ) = _$OrderSummaryCopyWithImpl<$Res, OrderSummary>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_number') String orderNumber,
    @JsonKey(name: 'outlet_name') String outletName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'grand_total') String grandTotal,
    @JsonKey(name: 'fulfillment_status') String fulfillmentStatus,
    @JsonKey(name: 'placed_at') DateTime placedAt,
    @JsonKey(name: 'item_count') int itemCount,
  });
}

/// @nodoc
class _$OrderSummaryCopyWithImpl<$Res, $Val extends OrderSummary>
    implements $OrderSummaryCopyWith<$Res> {
  _$OrderSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? outletName = null,
    Object? brandName = freezed,
    Object? grandTotal = null,
    Object? fulfillmentStatus = null,
    Object? placedAt = null,
    Object? itemCount = null,
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
            itemCount: null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderSummaryImplCopyWith<$Res>
    implements $OrderSummaryCopyWith<$Res> {
  factory _$$OrderSummaryImplCopyWith(
    _$OrderSummaryImpl value,
    $Res Function(_$OrderSummaryImpl) then,
  ) = __$$OrderSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_number') String orderNumber,
    @JsonKey(name: 'outlet_name') String outletName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'grand_total') String grandTotal,
    @JsonKey(name: 'fulfillment_status') String fulfillmentStatus,
    @JsonKey(name: 'placed_at') DateTime placedAt,
    @JsonKey(name: 'item_count') int itemCount,
  });
}

/// @nodoc
class __$$OrderSummaryImplCopyWithImpl<$Res>
    extends _$OrderSummaryCopyWithImpl<$Res, _$OrderSummaryImpl>
    implements _$$OrderSummaryImplCopyWith<$Res> {
  __$$OrderSummaryImplCopyWithImpl(
    _$OrderSummaryImpl _value,
    $Res Function(_$OrderSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? outletName = null,
    Object? brandName = freezed,
    Object? grandTotal = null,
    Object? fulfillmentStatus = null,
    Object? placedAt = null,
    Object? itemCount = null,
  }) {
    return _then(
      _$OrderSummaryImpl(
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
        itemCount: null == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderSummaryImpl implements _OrderSummary {
  const _$OrderSummaryImpl({
    required this.id,
    @JsonKey(name: 'order_number') required this.orderNumber,
    @JsonKey(name: 'outlet_name') this.outletName = '',
    @JsonKey(name: 'brand_name') this.brandName,
    @JsonKey(name: 'grand_total') required this.grandTotal,
    @JsonKey(name: 'fulfillment_status') required this.fulfillmentStatus,
    @JsonKey(name: 'placed_at') required this.placedAt,
    @JsonKey(name: 'item_count') this.itemCount = 0,
  });

  factory _$OrderSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderSummaryImplFromJson(json);

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
  @JsonKey(name: 'grand_total')
  final String grandTotal;
  @override
  @JsonKey(name: 'fulfillment_status')
  final String fulfillmentStatus;
  @override
  @JsonKey(name: 'placed_at')
  final DateTime placedAt;
  @override
  @JsonKey(name: 'item_count')
  final int itemCount;

  @override
  String toString() {
    return 'OrderSummary(id: $id, orderNumber: $orderNumber, outletName: $outletName, brandName: $brandName, grandTotal: $grandTotal, fulfillmentStatus: $fulfillmentStatus, placedAt: $placedAt, itemCount: $itemCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.outletName, outletName) ||
                other.outletName == outletName) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.fulfillmentStatus, fulfillmentStatus) ||
                other.fulfillmentStatus == fulfillmentStatus) &&
            (identical(other.placedAt, placedAt) ||
                other.placedAt == placedAt) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderNumber,
    outletName,
    brandName,
    grandTotal,
    fulfillmentStatus,
    placedAt,
    itemCount,
  );

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderSummaryImplCopyWith<_$OrderSummaryImpl> get copyWith =>
      __$$OrderSummaryImplCopyWithImpl<_$OrderSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderSummaryImplToJson(this);
  }
}

abstract class _OrderSummary implements OrderSummary {
  const factory _OrderSummary({
    required final String id,
    @JsonKey(name: 'order_number') required final String orderNumber,
    @JsonKey(name: 'outlet_name') final String outletName,
    @JsonKey(name: 'brand_name') final String? brandName,
    @JsonKey(name: 'grand_total') required final String grandTotal,
    @JsonKey(name: 'fulfillment_status')
    required final String fulfillmentStatus,
    @JsonKey(name: 'placed_at') required final DateTime placedAt,
    @JsonKey(name: 'item_count') final int itemCount,
  }) = _$OrderSummaryImpl;

  factory _OrderSummary.fromJson(Map<String, dynamic> json) =
      _$OrderSummaryImpl.fromJson;

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
  @JsonKey(name: 'grand_total')
  String get grandTotal;
  @override
  @JsonKey(name: 'fulfillment_status')
  String get fulfillmentStatus;
  @override
  @JsonKey(name: 'placed_at')
  DateTime get placedAt;
  @override
  @JsonKey(name: 'item_count')
  int get itemCount;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderSummaryImplCopyWith<_$OrderSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
