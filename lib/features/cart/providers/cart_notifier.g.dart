// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartNotifierHash() => r'd332f4a37710037f970eafc67de8232ebe83afd9';

/// Active cart for the current QR table session.
///
/// Persists across navigation (keepAlive). Cleared explicitly via [clearCart]
/// on logout or when a new QR session is resolved.
///
/// Price arithmetic uses [double.parse] on the String decimal from the API
/// to avoid spreading raw strings into the UI.
///
/// Copied from [CartNotifier].
@ProviderFor(CartNotifier)
final cartNotifierProvider =
    NotifierProvider<CartNotifier, List<CartItem>>.internal(
      CartNotifier.new,
      name: r'cartNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cartNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CartNotifier = Notifier<List<CartItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
