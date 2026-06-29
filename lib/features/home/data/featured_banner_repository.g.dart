// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_banner_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$featuredBannersHash() => r'd8130802e25b4e59ab12ba1616d06e0b8331d7d1';

/// Fetches active featured banners from the public (no-auth) endpoint.
///
/// Copied from [featuredBanners].
@ProviderFor(featuredBanners)
final featuredBannersProvider =
    AutoDisposeFutureProvider<List<FeaturedBanner>>.internal(
      featuredBanners,
      name: r'featuredBannersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$featuredBannersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedBannersRef = AutoDisposeFutureProviderRef<List<FeaturedBanner>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
