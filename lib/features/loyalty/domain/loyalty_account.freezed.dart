// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loyalty_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoyaltyTransaction _$LoyaltyTransactionFromJson(Map<String, dynamic> json) {
  return _LoyaltyTransaction.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyTransaction {
  String get id => throw _privateConstructorUsedError;

  /// 'EARN' or 'REDEEM'
  @JsonKey(name: 'txn_type')
  String get txnType => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_after')
  int get balanceAfter => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_type')
  String? get referenceType => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_id')
  String? get referenceId => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this LoyaltyTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoyaltyTransactionCopyWith<LoyaltyTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyTransactionCopyWith<$Res> {
  factory $LoyaltyTransactionCopyWith(
    LoyaltyTransaction value,
    $Res Function(LoyaltyTransaction) then,
  ) = _$LoyaltyTransactionCopyWithImpl<$Res, LoyaltyTransaction>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'txn_type') String txnType,
    int points,
    @JsonKey(name: 'balance_after') int balanceAfter,
    @JsonKey(name: 'reference_type') String? referenceType,
    @JsonKey(name: 'reference_id') String? referenceId,
    String? note,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$LoyaltyTransactionCopyWithImpl<$Res, $Val extends LoyaltyTransaction>
    implements $LoyaltyTransactionCopyWith<$Res> {
  _$LoyaltyTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? txnType = null,
    Object? points = null,
    Object? balanceAfter = null,
    Object? referenceType = freezed,
    Object? referenceId = freezed,
    Object? note = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            txnType: null == txnType
                ? _value.txnType
                : txnType // ignore: cast_nullable_to_non_nullable
                      as String,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            balanceAfter: null == balanceAfter
                ? _value.balanceAfter
                : balanceAfter // ignore: cast_nullable_to_non_nullable
                      as int,
            referenceType: freezed == referenceType
                ? _value.referenceType
                : referenceType // ignore: cast_nullable_to_non_nullable
                      as String?,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoyaltyTransactionImplCopyWith<$Res>
    implements $LoyaltyTransactionCopyWith<$Res> {
  factory _$$LoyaltyTransactionImplCopyWith(
    _$LoyaltyTransactionImpl value,
    $Res Function(_$LoyaltyTransactionImpl) then,
  ) = __$$LoyaltyTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'txn_type') String txnType,
    int points,
    @JsonKey(name: 'balance_after') int balanceAfter,
    @JsonKey(name: 'reference_type') String? referenceType,
    @JsonKey(name: 'reference_id') String? referenceId,
    String? note,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$LoyaltyTransactionImplCopyWithImpl<$Res>
    extends _$LoyaltyTransactionCopyWithImpl<$Res, _$LoyaltyTransactionImpl>
    implements _$$LoyaltyTransactionImplCopyWith<$Res> {
  __$$LoyaltyTransactionImplCopyWithImpl(
    _$LoyaltyTransactionImpl _value,
    $Res Function(_$LoyaltyTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? txnType = null,
    Object? points = null,
    Object? balanceAfter = null,
    Object? referenceType = freezed,
    Object? referenceId = freezed,
    Object? note = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$LoyaltyTransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        txnType: null == txnType
            ? _value.txnType
            : txnType // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        balanceAfter: null == balanceAfter
            ? _value.balanceAfter
            : balanceAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        referenceType: freezed == referenceType
            ? _value.referenceType
            : referenceType // ignore: cast_nullable_to_non_nullable
                  as String?,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyTransactionImpl implements _LoyaltyTransaction {
  const _$LoyaltyTransactionImpl({
    required this.id,
    @JsonKey(name: 'txn_type') required this.txnType,
    required this.points,
    @JsonKey(name: 'balance_after') required this.balanceAfter,
    @JsonKey(name: 'reference_type') this.referenceType,
    @JsonKey(name: 'reference_id') this.referenceId,
    this.note,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$LoyaltyTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyTransactionImplFromJson(json);

  @override
  final String id;

  /// 'EARN' or 'REDEEM'
  @override
  @JsonKey(name: 'txn_type')
  final String txnType;
  @override
  final int points;
  @override
  @JsonKey(name: 'balance_after')
  final int balanceAfter;
  @override
  @JsonKey(name: 'reference_type')
  final String? referenceType;
  @override
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @override
  final String? note;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'LoyaltyTransaction(id: $id, txnType: $txnType, points: $points, balanceAfter: $balanceAfter, referenceType: $referenceType, referenceId: $referenceId, note: $note, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.txnType, txnType) || other.txnType == txnType) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    txnType,
    points,
    balanceAfter,
    referenceType,
    referenceId,
    note,
    createdAt,
  );

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyTransactionImplCopyWith<_$LoyaltyTransactionImpl> get copyWith =>
      __$$LoyaltyTransactionImplCopyWithImpl<_$LoyaltyTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyTransactionImplToJson(this);
  }
}

abstract class _LoyaltyTransaction implements LoyaltyTransaction {
  const factory _LoyaltyTransaction({
    required final String id,
    @JsonKey(name: 'txn_type') required final String txnType,
    required final int points,
    @JsonKey(name: 'balance_after') required final int balanceAfter,
    @JsonKey(name: 'reference_type') final String? referenceType,
    @JsonKey(name: 'reference_id') final String? referenceId,
    final String? note,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$LoyaltyTransactionImpl;

  factory _LoyaltyTransaction.fromJson(Map<String, dynamic> json) =
      _$LoyaltyTransactionImpl.fromJson;

  @override
  String get id;

  /// 'EARN' or 'REDEEM'
  @override
  @JsonKey(name: 'txn_type')
  String get txnType;
  @override
  int get points;
  @override
  @JsonKey(name: 'balance_after')
  int get balanceAfter;
  @override
  @JsonKey(name: 'reference_type')
  String? get referenceType;
  @override
  @JsonKey(name: 'reference_id')
  String? get referenceId;
  @override
  String? get note;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of LoyaltyTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoyaltyTransactionImplCopyWith<_$LoyaltyTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoyaltyAccount _$LoyaltyAccountFromJson(Map<String, dynamic> json) {
  return _LoyaltyAccount.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyAccount {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'points_balance')
  int get pointsBalance => throw _privateConstructorUsedError;

  /// Raw backend value: 'BRONZE' | 'SILVER' | 'GOLD'
  String get tier => throw _privateConstructorUsedError;

  /// Points earned in the current tier-calculation window (previous month).
  @JsonKey(name: 'tier_points_in_window')
  int get tierPointsInWindow => throw _privateConstructorUsedError;
  List<LoyaltyTransaction> get transactions =>
      throw _privateConstructorUsedError;

  /// Serializes this LoyaltyAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoyaltyAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoyaltyAccountCopyWith<LoyaltyAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyAccountCopyWith<$Res> {
  factory $LoyaltyAccountCopyWith(
    LoyaltyAccount value,
    $Res Function(LoyaltyAccount) then,
  ) = _$LoyaltyAccountCopyWithImpl<$Res, LoyaltyAccount>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'points_balance') int pointsBalance,
    String tier,
    @JsonKey(name: 'tier_points_in_window') int tierPointsInWindow,
    List<LoyaltyTransaction> transactions,
  });
}

/// @nodoc
class _$LoyaltyAccountCopyWithImpl<$Res, $Val extends LoyaltyAccount>
    implements $LoyaltyAccountCopyWith<$Res> {
  _$LoyaltyAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoyaltyAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pointsBalance = null,
    Object? tier = null,
    Object? tierPointsInWindow = null,
    Object? transactions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pointsBalance: null == pointsBalance
                ? _value.pointsBalance
                : pointsBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as String,
            tierPointsInWindow: null == tierPointsInWindow
                ? _value.tierPointsInWindow
                : tierPointsInWindow // ignore: cast_nullable_to_non_nullable
                      as int,
            transactions: null == transactions
                ? _value.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                      as List<LoyaltyTransaction>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoyaltyAccountImplCopyWith<$Res>
    implements $LoyaltyAccountCopyWith<$Res> {
  factory _$$LoyaltyAccountImplCopyWith(
    _$LoyaltyAccountImpl value,
    $Res Function(_$LoyaltyAccountImpl) then,
  ) = __$$LoyaltyAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'points_balance') int pointsBalance,
    String tier,
    @JsonKey(name: 'tier_points_in_window') int tierPointsInWindow,
    List<LoyaltyTransaction> transactions,
  });
}

/// @nodoc
class __$$LoyaltyAccountImplCopyWithImpl<$Res>
    extends _$LoyaltyAccountCopyWithImpl<$Res, _$LoyaltyAccountImpl>
    implements _$$LoyaltyAccountImplCopyWith<$Res> {
  __$$LoyaltyAccountImplCopyWithImpl(
    _$LoyaltyAccountImpl _value,
    $Res Function(_$LoyaltyAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoyaltyAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pointsBalance = null,
    Object? tier = null,
    Object? tierPointsInWindow = null,
    Object? transactions = null,
  }) {
    return _then(
      _$LoyaltyAccountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pointsBalance: null == pointsBalance
            ? _value.pointsBalance
            : pointsBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as String,
        tierPointsInWindow: null == tierPointsInWindow
            ? _value.tierPointsInWindow
            : tierPointsInWindow // ignore: cast_nullable_to_non_nullable
                  as int,
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<LoyaltyTransaction>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyAccountImpl implements _LoyaltyAccount {
  const _$LoyaltyAccountImpl({
    required this.id,
    @JsonKey(name: 'points_balance') required this.pointsBalance,
    required this.tier,
    @JsonKey(name: 'tier_points_in_window') required this.tierPointsInWindow,
    final List<LoyaltyTransaction> transactions = const [],
  }) : _transactions = transactions;

  factory _$LoyaltyAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyAccountImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'points_balance')
  final int pointsBalance;

  /// Raw backend value: 'BRONZE' | 'SILVER' | 'GOLD'
  @override
  final String tier;

  /// Points earned in the current tier-calculation window (previous month).
  @override
  @JsonKey(name: 'tier_points_in_window')
  final int tierPointsInWindow;
  final List<LoyaltyTransaction> _transactions;
  @override
  @JsonKey()
  List<LoyaltyTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  String toString() {
    return 'LoyaltyAccount(id: $id, pointsBalance: $pointsBalance, tier: $tier, tierPointsInWindow: $tierPointsInWindow, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pointsBalance, pointsBalance) ||
                other.pointsBalance == pointsBalance) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.tierPointsInWindow, tierPointsInWindow) ||
                other.tierPointsInWindow == tierPointsInWindow) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    pointsBalance,
    tier,
    tierPointsInWindow,
    const DeepCollectionEquality().hash(_transactions),
  );

  /// Create a copy of LoyaltyAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyAccountImplCopyWith<_$LoyaltyAccountImpl> get copyWith =>
      __$$LoyaltyAccountImplCopyWithImpl<_$LoyaltyAccountImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyAccountImplToJson(this);
  }
}

abstract class _LoyaltyAccount implements LoyaltyAccount {
  const factory _LoyaltyAccount({
    required final String id,
    @JsonKey(name: 'points_balance') required final int pointsBalance,
    required final String tier,
    @JsonKey(name: 'tier_points_in_window')
    required final int tierPointsInWindow,
    final List<LoyaltyTransaction> transactions,
  }) = _$LoyaltyAccountImpl;

  factory _LoyaltyAccount.fromJson(Map<String, dynamic> json) =
      _$LoyaltyAccountImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'points_balance')
  int get pointsBalance;

  /// Raw backend value: 'BRONZE' | 'SILVER' | 'GOLD'
  @override
  String get tier;

  /// Points earned in the current tier-calculation window (previous month).
  @override
  @JsonKey(name: 'tier_points_in_window')
  int get tierPointsInWindow;
  @override
  List<LoyaltyTransaction> get transactions;

  /// Create a copy of LoyaltyAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoyaltyAccountImplCopyWith<_$LoyaltyAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
