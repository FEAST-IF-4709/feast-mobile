// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qris_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QrisPayment _$QrisPaymentFromJson(Map<String, dynamic> json) {
  return _QrisPayment.fromJson(json);
}

/// @nodoc
mixin _$QrisPayment {
  @JsonKey(name: 'transaction_id')
  String get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'qr_string')
  String get qrString => throw _privateConstructorUsedError;
  @JsonKey(name: 'qr_image_url')
  String get qrImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;

  /// Serializes this QrisPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrisPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrisPaymentCopyWith<QrisPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrisPaymentCopyWith<$Res> {
  factory $QrisPaymentCopyWith(
    QrisPayment value,
    $Res Function(QrisPayment) then,
  ) = _$QrisPaymentCopyWithImpl<$Res, QrisPayment>;
  @useResult
  $Res call({
    @JsonKey(name: 'transaction_id') String transactionId,
    @JsonKey(name: 'qr_string') String qrString,
    @JsonKey(name: 'qr_image_url') String qrImageUrl,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
    String amount,
  });
}

/// @nodoc
class _$QrisPaymentCopyWithImpl<$Res, $Val extends QrisPayment>
    implements $QrisPaymentCopyWith<$Res> {
  _$QrisPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrisPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? qrString = null,
    Object? qrImageUrl = null,
    Object? expiresAt = null,
    Object? amount = null,
  }) {
    return _then(
      _value.copyWith(
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
            qrString: null == qrString
                ? _value.qrString
                : qrString // ignore: cast_nullable_to_non_nullable
                      as String,
            qrImageUrl: null == qrImageUrl
                ? _value.qrImageUrl
                : qrImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QrisPaymentImplCopyWith<$Res>
    implements $QrisPaymentCopyWith<$Res> {
  factory _$$QrisPaymentImplCopyWith(
    _$QrisPaymentImpl value,
    $Res Function(_$QrisPaymentImpl) then,
  ) = __$$QrisPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'transaction_id') String transactionId,
    @JsonKey(name: 'qr_string') String qrString,
    @JsonKey(name: 'qr_image_url') String qrImageUrl,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
    String amount,
  });
}

/// @nodoc
class __$$QrisPaymentImplCopyWithImpl<$Res>
    extends _$QrisPaymentCopyWithImpl<$Res, _$QrisPaymentImpl>
    implements _$$QrisPaymentImplCopyWith<$Res> {
  __$$QrisPaymentImplCopyWithImpl(
    _$QrisPaymentImpl _value,
    $Res Function(_$QrisPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QrisPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? qrString = null,
    Object? qrImageUrl = null,
    Object? expiresAt = null,
    Object? amount = null,
  }) {
    return _then(
      _$QrisPaymentImpl(
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        qrString: null == qrString
            ? _value.qrString
            : qrString // ignore: cast_nullable_to_non_nullable
                  as String,
        qrImageUrl: null == qrImageUrl
            ? _value.qrImageUrl
            : qrImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QrisPaymentImpl implements _QrisPayment {
  const _$QrisPaymentImpl({
    @JsonKey(name: 'transaction_id') required this.transactionId,
    @JsonKey(name: 'qr_string') required this.qrString,
    @JsonKey(name: 'qr_image_url') required this.qrImageUrl,
    @JsonKey(name: 'expires_at') required this.expiresAt,
    required this.amount,
  });

  factory _$QrisPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrisPaymentImplFromJson(json);

  @override
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @override
  @JsonKey(name: 'qr_string')
  final String qrString;
  @override
  @JsonKey(name: 'qr_image_url')
  final String qrImageUrl;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;
  @override
  final String amount;

  @override
  String toString() {
    return 'QrisPayment(transactionId: $transactionId, qrString: $qrString, qrImageUrl: $qrImageUrl, expiresAt: $expiresAt, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrisPaymentImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.qrString, qrString) ||
                other.qrString == qrString) &&
            (identical(other.qrImageUrl, qrImageUrl) ||
                other.qrImageUrl == qrImageUrl) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    transactionId,
    qrString,
    qrImageUrl,
    expiresAt,
    amount,
  );

  /// Create a copy of QrisPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrisPaymentImplCopyWith<_$QrisPaymentImpl> get copyWith =>
      __$$QrisPaymentImplCopyWithImpl<_$QrisPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrisPaymentImplToJson(this);
  }
}

abstract class _QrisPayment implements QrisPayment {
  const factory _QrisPayment({
    @JsonKey(name: 'transaction_id') required final String transactionId,
    @JsonKey(name: 'qr_string') required final String qrString,
    @JsonKey(name: 'qr_image_url') required final String qrImageUrl,
    @JsonKey(name: 'expires_at') required final DateTime expiresAt,
    required final String amount,
  }) = _$QrisPaymentImpl;

  factory _QrisPayment.fromJson(Map<String, dynamic> json) =
      _$QrisPaymentImpl.fromJson;

  @override
  @JsonKey(name: 'transaction_id')
  String get transactionId;
  @override
  @JsonKey(name: 'qr_string')
  String get qrString;
  @override
  @JsonKey(name: 'qr_image_url')
  String get qrImageUrl;
  @override
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt;
  @override
  String get amount;

  /// Create a copy of QrisPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrisPaymentImplCopyWith<_$QrisPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
