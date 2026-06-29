// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderResult _$OrderResultFromJson(Map<String, dynamic> json) {
  return _OrderResult.fromJson(json);
}

/// @nodoc
mixin _$OrderResult {
  @JsonKey(name: 'order_id')
  String get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_number')
  String get orderNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'subtotal')
  String get subtotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_total')
  String get discountTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  String get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  String get grandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'valid_payment_methods')
  List<String> get validPaymentMethods => throw _privateConstructorUsedError;

  /// Serializes this OrderResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderResultCopyWith<OrderResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderResultCopyWith<$Res> {
  factory $OrderResultCopyWith(
    OrderResult value,
    $Res Function(OrderResult) then,
  ) = _$OrderResultCopyWithImpl<$Res, OrderResult>;
  @useResult
  $Res call({
    @JsonKey(name: 'order_id') String orderId,
    @JsonKey(name: 'order_number') String orderNumber,
    @JsonKey(name: 'subtotal') String subtotal,
    @JsonKey(name: 'discount_total') String discountTotal,
    @JsonKey(name: 'tax_amount') String taxAmount,
    @JsonKey(name: 'grand_total') String grandTotal,
    @JsonKey(name: 'valid_payment_methods') List<String> validPaymentMethods,
  });
}

/// @nodoc
class _$OrderResultCopyWithImpl<$Res, $Val extends OrderResult>
    implements $OrderResultCopyWith<$Res> {
  _$OrderResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderNumber = null,
    Object? subtotal = null,
    Object? discountTotal = null,
    Object? taxAmount = null,
    Object? grandTotal = null,
    Object? validPaymentMethods = null,
  }) {
    return _then(
      _value.copyWith(
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            orderNumber: null == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as String,
            discountTotal: null == discountTotal
                ? _value.discountTotal
                : discountTotal // ignore: cast_nullable_to_non_nullable
                      as String,
            taxAmount: null == taxAmount
                ? _value.taxAmount
                : taxAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            grandTotal: null == grandTotal
                ? _value.grandTotal
                : grandTotal // ignore: cast_nullable_to_non_nullable
                      as String,
            validPaymentMethods: null == validPaymentMethods
                ? _value.validPaymentMethods
                : validPaymentMethods // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderResultImplCopyWith<$Res>
    implements $OrderResultCopyWith<$Res> {
  factory _$$OrderResultImplCopyWith(
    _$OrderResultImpl value,
    $Res Function(_$OrderResultImpl) then,
  ) = __$$OrderResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'order_id') String orderId,
    @JsonKey(name: 'order_number') String orderNumber,
    @JsonKey(name: 'subtotal') String subtotal,
    @JsonKey(name: 'discount_total') String discountTotal,
    @JsonKey(name: 'tax_amount') String taxAmount,
    @JsonKey(name: 'grand_total') String grandTotal,
    @JsonKey(name: 'valid_payment_methods') List<String> validPaymentMethods,
  });
}

/// @nodoc
class __$$OrderResultImplCopyWithImpl<$Res>
    extends _$OrderResultCopyWithImpl<$Res, _$OrderResultImpl>
    implements _$$OrderResultImplCopyWith<$Res> {
  __$$OrderResultImplCopyWithImpl(
    _$OrderResultImpl _value,
    $Res Function(_$OrderResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? orderNumber = null,
    Object? subtotal = null,
    Object? discountTotal = null,
    Object? taxAmount = null,
    Object? grandTotal = null,
    Object? validPaymentMethods = null,
  }) {
    return _then(
      _$OrderResultImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderNumber: null == orderNumber
            ? _value.orderNumber
            : orderNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as String,
        discountTotal: null == discountTotal
            ? _value.discountTotal
            : discountTotal // ignore: cast_nullable_to_non_nullable
                  as String,
        taxAmount: null == taxAmount
            ? _value.taxAmount
            : taxAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        grandTotal: null == grandTotal
            ? _value.grandTotal
            : grandTotal // ignore: cast_nullable_to_non_nullable
                  as String,
        validPaymentMethods: null == validPaymentMethods
            ? _value._validPaymentMethods
            : validPaymentMethods // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderResultImpl implements _OrderResult {
  const _$OrderResultImpl({
    @JsonKey(name: 'order_id') required this.orderId,
    @JsonKey(name: 'order_number') required this.orderNumber,
    @JsonKey(name: 'subtotal') required this.subtotal,
    @JsonKey(name: 'discount_total') this.discountTotal = '0',
    @JsonKey(name: 'tax_amount') required this.taxAmount,
    @JsonKey(name: 'grand_total') required this.grandTotal,
    @JsonKey(name: 'valid_payment_methods')
    required final List<String> validPaymentMethods,
  }) : _validPaymentMethods = validPaymentMethods;

  factory _$OrderResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderResultImplFromJson(json);

  @override
  @JsonKey(name: 'order_id')
  final String orderId;
  @override
  @JsonKey(name: 'order_number')
  final String orderNumber;
  @override
  @JsonKey(name: 'subtotal')
  final String subtotal;
  @override
  @JsonKey(name: 'discount_total')
  final String discountTotal;
  @override
  @JsonKey(name: 'tax_amount')
  final String taxAmount;
  @override
  @JsonKey(name: 'grand_total')
  final String grandTotal;
  final List<String> _validPaymentMethods;
  @override
  @JsonKey(name: 'valid_payment_methods')
  List<String> get validPaymentMethods {
    if (_validPaymentMethods is EqualUnmodifiableListView)
      return _validPaymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validPaymentMethods);
  }

  @override
  String toString() {
    return 'OrderResult(orderId: $orderId, orderNumber: $orderNumber, subtotal: $subtotal, discountTotal: $discountTotal, taxAmount: $taxAmount, grandTotal: $grandTotal, validPaymentMethods: $validPaymentMethods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderResultImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discountTotal, discountTotal) ||
                other.discountTotal == discountTotal) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            const DeepCollectionEquality().equals(
              other._validPaymentMethods,
              _validPaymentMethods,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    orderNumber,
    subtotal,
    discountTotal,
    taxAmount,
    grandTotal,
    const DeepCollectionEquality().hash(_validPaymentMethods),
  );

  /// Create a copy of OrderResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderResultImplCopyWith<_$OrderResultImpl> get copyWith =>
      __$$OrderResultImplCopyWithImpl<_$OrderResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderResultImplToJson(this);
  }
}

abstract class _OrderResult implements OrderResult {
  const factory _OrderResult({
    @JsonKey(name: 'order_id') required final String orderId,
    @JsonKey(name: 'order_number') required final String orderNumber,
    @JsonKey(name: 'subtotal') required final String subtotal,
    @JsonKey(name: 'discount_total') final String discountTotal,
    @JsonKey(name: 'tax_amount') required final String taxAmount,
    @JsonKey(name: 'grand_total') required final String grandTotal,
    @JsonKey(name: 'valid_payment_methods')
    required final List<String> validPaymentMethods,
  }) = _$OrderResultImpl;

  factory _OrderResult.fromJson(Map<String, dynamic> json) =
      _$OrderResultImpl.fromJson;

  @override
  @JsonKey(name: 'order_id')
  String get orderId;
  @override
  @JsonKey(name: 'order_number')
  String get orderNumber;
  @override
  @JsonKey(name: 'subtotal')
  String get subtotal;
  @override
  @JsonKey(name: 'discount_total')
  String get discountTotal;
  @override
  @JsonKey(name: 'tax_amount')
  String get taxAmount;
  @override
  @JsonKey(name: 'grand_total')
  String get grandTotal;
  @override
  @JsonKey(name: 'valid_payment_methods')
  List<String> get validPaymentMethods;

  /// Create a copy of OrderResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderResultImplCopyWith<_$OrderResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
