// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loyaltyAccountHash() => r'11f4450c7124a388280ba31fb87027fef01d8370';

/// Customer's loyalty account — kept alive so HomeScreen, ProfileScreen, and
/// MembershipScreen all share the same fetch without re-requesting.
/// Invalidate via [ref.invalidate(loyaltyAccountProvider)] after an order
/// completes to refresh the balance.
///
/// Copied from [loyaltyAccount].
@ProviderFor(loyaltyAccount)
final loyaltyAccountProvider = FutureProvider<LoyaltyAccount>.internal(
  loyaltyAccount,
  name: r'loyaltyAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loyaltyAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoyaltyAccountRef = FutureProviderRef<LoyaltyAccount>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
