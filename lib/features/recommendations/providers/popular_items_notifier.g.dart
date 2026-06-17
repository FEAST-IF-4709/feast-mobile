// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_items_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$popularItemsNotifierHash() =>
    r'bc2d18656c55760df25b50a641abc1c0e3d8ca0f';

/// Fetches the top-selling products for the current outlet session.
///
/// Returns `null` when no QR session is active.
/// Invalidate to refresh: `ref.invalidate(popularItemsNotifierProvider)`.
///
/// Copied from [PopularItemsNotifier].
@ProviderFor(PopularItemsNotifier)
final popularItemsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      PopularItemsNotifier,
      List<PopularItem>?
    >.internal(
      PopularItemsNotifier.new,
      name: r'popularItemsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$popularItemsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PopularItemsNotifier = AutoDisposeAsyncNotifier<List<PopularItem>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
