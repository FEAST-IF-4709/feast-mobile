// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$brandNotifierHash() => r'241a00d845727bf8a232c30f91e5d58ad45fc8c0';

/// Fetches and holds the full list of brands.
///
/// This is a public endpoint — no QR session required.
/// Invalidate to trigger a refresh:
/// ```dart
/// ref.invalidate(brandNotifierProvider);
/// ```
///
/// Copied from [BrandNotifier].
@ProviderFor(BrandNotifier)
final brandNotifierProvider =
    AutoDisposeAsyncNotifierProvider<BrandNotifier, List<Brand>>.internal(
      BrandNotifier.new,
      name: r'brandNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$brandNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BrandNotifier = AutoDisposeAsyncNotifier<List<Brand>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
