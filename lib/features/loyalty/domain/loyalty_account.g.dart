// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoyaltyTransactionImpl _$$LoyaltyTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$LoyaltyTransactionImpl(
  id: json['id'] as String,
  txnType: json['txn_type'] as String,
  points: (json['points'] as num).toInt(),
  balanceAfter: (json['balance_after'] as num).toInt(),
  referenceType: json['reference_type'] as String?,
  referenceId: json['reference_id'] as String?,
  note: json['note'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$LoyaltyTransactionImplToJson(
  _$LoyaltyTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'txn_type': instance.txnType,
  'points': instance.points,
  'balance_after': instance.balanceAfter,
  'reference_type': instance.referenceType,
  'reference_id': instance.referenceId,
  'note': instance.note,
  'created_at': instance.createdAt.toIso8601String(),
};

_$LoyaltyAccountImpl _$$LoyaltyAccountImplFromJson(Map<String, dynamic> json) =>
    _$LoyaltyAccountImpl(
      id: json['id'] as String,
      pointsBalance: (json['points_balance'] as num).toInt(),
      tier: json['tier'] as String,
      tierPointsInWindow: (json['tier_points_in_window'] as num).toInt(),
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map(
                (e) => LoyaltyTransaction.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LoyaltyAccountImplToJson(
  _$LoyaltyAccountImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'points_balance': instance.pointsBalance,
  'tier': instance.tier,
  'tier_points_in_window': instance.tierPointsInWindow,
  'transactions': instance.transactions,
};
