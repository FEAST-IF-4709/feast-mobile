// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_order_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeOrderNotifierHash() =>
    r'86a1efea2541621903b0195fd9730346662354df';

/// Persists the ID of the order that is currently in-flight (payment pending
/// through to terminal fulfillment status).
///
/// Kept alive so [AppOrderWatcher] can hold a permanent listener on
/// [OrderTrackingNotifier] regardless of which screen is visible — ensuring
/// the WebSocket stays connected and in-app notifications fire everywhere.
///
/// Lifecycle:
///   set  → [CartScreen] calls [setActiveOrder] right after `createOrder`.
///   clear → [OrderTrackingNotifier] calls [clearActiveOrder] when the order
///            reaches a terminal fulfillment status (SERVED / COMPLETED /
///            CANCELLED).
///
/// Copied from [ActiveOrderNotifier].
@ProviderFor(ActiveOrderNotifier)
final activeOrderNotifierProvider =
    AsyncNotifierProvider<ActiveOrderNotifier, String?>.internal(
      ActiveOrderNotifier.new,
      name: r'activeOrderNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeOrderNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActiveOrderNotifier = AsyncNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
