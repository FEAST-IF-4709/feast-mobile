import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/loyalty_repository.dart';
import '../domain/loyalty_account.dart';

part 'loyalty_notifier.g.dart';

/// Customer's loyalty account — kept alive so HomeScreen, ProfileScreen, and
/// MembershipScreen all share the same fetch without re-requesting.
/// Invalidate via [ref.invalidate(loyaltyAccountProvider)] after an order
/// completes to refresh the balance.
@Riverpod(keepAlive: true)
Future<LoyaltyAccount> loyaltyAccount(LoyaltyAccountRef ref) =>
    ref.read(loyaltyRepositoryProvider).getLoyalty();
