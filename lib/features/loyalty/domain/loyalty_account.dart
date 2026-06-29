// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_account.freezed.dart';
part 'loyalty_account.g.dart';

/// Single entry in the loyalty ledger (LoyaltyTransactionSerializer).
@freezed
class LoyaltyTransaction with _$LoyaltyTransaction {
  const factory LoyaltyTransaction({
    required String id,
    /// 'EARN' or 'REDEEM'
    @JsonKey(name: 'txn_type') required String txnType,
    required int points,
    @JsonKey(name: 'balance_after') required int balanceAfter,
    @JsonKey(name: 'reference_type') String? referenceType,
    @JsonKey(name: 'reference_id') String? referenceId,
    String? note,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _LoyaltyTransaction;

  factory LoyaltyTransaction.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyTransactionFromJson(json);
}

/// Customer loyalty account from GET /api/v1/customers/me/loyalty/.
///
/// Tier thresholds are client-side constants that mirror backend loyalty.py:
///   BRONZE  → tier_points_in_window < 100
///   SILVER  → 100 ≤ tier_points_in_window < 200
///   GOLD    → tier_points_in_window ≥ 200
/// These may change if the backend adjusts thresholds; update [kTierThresholds].
@freezed
class LoyaltyAccount with _$LoyaltyAccount {
  const factory LoyaltyAccount({
    required String id,
    @JsonKey(name: 'points_balance') required int pointsBalance,
    /// Raw backend value: 'BRONZE' | 'SILVER' | 'GOLD'
    required String tier,
    /// Points earned in the current tier-calculation window (previous month).
    @JsonKey(name: 'tier_points_in_window') required int tierPointsInWindow,
    /// Number of AVAILABLE (unredeemed, non-expired) vouchers the customer owns.
    @JsonKey(name: 'active_voucher_count') @Default(0) int activeVoucherCount,
    @Default([]) List<LoyaltyTransaction> transactions,
  }) = _LoyaltyAccount;

  factory LoyaltyAccount.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyAccountFromJson(json);
}

/// Client-side tier thresholds mirroring backend apps/customers/loyalty.py.
/// Pending backend M8 integration — swap for server-reported values if available.
const kTierThresholds = {'SILVER': 100, 'GOLD': 200};
