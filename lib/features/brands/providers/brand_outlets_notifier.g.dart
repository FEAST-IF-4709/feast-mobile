// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_outlets_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearestOutletPerBrandHash() =>
    r'ffffac2f70bc2a4293f07920d80cbfe27464a1e3';

/// Maps brandId → nearest [Outlet] for the brand list screen.
///
/// One API call fetches all nearby outlets; results arrive pre-sorted
/// nearest-first, so the first outlet seen per brand is the nearest one.
/// Returns an empty map when location is unavailable.
///
/// Copied from [nearestOutletPerBrand].
@ProviderFor(nearestOutletPerBrand)
final nearestOutletPerBrandProvider =
    AutoDisposeFutureProvider<Map<String, Outlet>>.internal(
      nearestOutletPerBrand,
      name: r'nearestOutletPerBrandProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$nearestOutletPerBrandHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NearestOutletPerBrandRef =
    AutoDisposeFutureProviderRef<Map<String, Outlet>>;
String _$brandOutletsHash() => r'99b835a08c193bd630ca1d7638376b3a71425a19';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Fetches outlets for [brandId].
///
/// When location is available, results come back sorted nearest-first by the
/// backend. When location is unavailable (permission denied / GPS off), all
/// outlets for the brand are fetched without distance filtering and sorted
/// alphabetically by name on the client side.
///
/// Invalidate to trigger a refresh:
/// ```dart
/// ref.invalidate(brandOutletsProvider(brandId));
/// ```
///
/// Copied from [brandOutlets].
@ProviderFor(brandOutlets)
const brandOutletsProvider = BrandOutletsFamily();

/// Fetches outlets for [brandId].
///
/// When location is available, results come back sorted nearest-first by the
/// backend. When location is unavailable (permission denied / GPS off), all
/// outlets for the brand are fetched without distance filtering and sorted
/// alphabetically by name on the client side.
///
/// Invalidate to trigger a refresh:
/// ```dart
/// ref.invalidate(brandOutletsProvider(brandId));
/// ```
///
/// Copied from [brandOutlets].
class BrandOutletsFamily extends Family<AsyncValue<List<Outlet>>> {
  /// Fetches outlets for [brandId].
  ///
  /// When location is available, results come back sorted nearest-first by the
  /// backend. When location is unavailable (permission denied / GPS off), all
  /// outlets for the brand are fetched without distance filtering and sorted
  /// alphabetically by name on the client side.
  ///
  /// Invalidate to trigger a refresh:
  /// ```dart
  /// ref.invalidate(brandOutletsProvider(brandId));
  /// ```
  ///
  /// Copied from [brandOutlets].
  const BrandOutletsFamily();

  /// Fetches outlets for [brandId].
  ///
  /// When location is available, results come back sorted nearest-first by the
  /// backend. When location is unavailable (permission denied / GPS off), all
  /// outlets for the brand are fetched without distance filtering and sorted
  /// alphabetically by name on the client side.
  ///
  /// Invalidate to trigger a refresh:
  /// ```dart
  /// ref.invalidate(brandOutletsProvider(brandId));
  /// ```
  ///
  /// Copied from [brandOutlets].
  BrandOutletsProvider call(String brandId) {
    return BrandOutletsProvider(brandId);
  }

  @override
  BrandOutletsProvider getProviderOverride(
    covariant BrandOutletsProvider provider,
  ) {
    return call(provider.brandId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'brandOutletsProvider';
}

/// Fetches outlets for [brandId].
///
/// When location is available, results come back sorted nearest-first by the
/// backend. When location is unavailable (permission denied / GPS off), all
/// outlets for the brand are fetched without distance filtering and sorted
/// alphabetically by name on the client side.
///
/// Invalidate to trigger a refresh:
/// ```dart
/// ref.invalidate(brandOutletsProvider(brandId));
/// ```
///
/// Copied from [brandOutlets].
class BrandOutletsProvider extends AutoDisposeFutureProvider<List<Outlet>> {
  /// Fetches outlets for [brandId].
  ///
  /// When location is available, results come back sorted nearest-first by the
  /// backend. When location is unavailable (permission denied / GPS off), all
  /// outlets for the brand are fetched without distance filtering and sorted
  /// alphabetically by name on the client side.
  ///
  /// Invalidate to trigger a refresh:
  /// ```dart
  /// ref.invalidate(brandOutletsProvider(brandId));
  /// ```
  ///
  /// Copied from [brandOutlets].
  BrandOutletsProvider(String brandId)
    : this._internal(
        (ref) => brandOutlets(ref as BrandOutletsRef, brandId),
        from: brandOutletsProvider,
        name: r'brandOutletsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$brandOutletsHash,
        dependencies: BrandOutletsFamily._dependencies,
        allTransitiveDependencies:
            BrandOutletsFamily._allTransitiveDependencies,
        brandId: brandId,
      );

  BrandOutletsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brandId,
  }) : super.internal();

  final String brandId;

  @override
  Override overrideWith(
    FutureOr<List<Outlet>> Function(BrandOutletsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BrandOutletsProvider._internal(
        (ref) => create(ref as BrandOutletsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brandId: brandId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Outlet>> createElement() {
    return _BrandOutletsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BrandOutletsProvider && other.brandId == brandId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brandId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BrandOutletsRef on AutoDisposeFutureProviderRef<List<Outlet>> {
  /// The parameter `brandId` of this provider.
  String get brandId;
}

class _BrandOutletsProviderElement
    extends AutoDisposeFutureProviderElement<List<Outlet>>
    with BrandOutletsRef {
  _BrandOutletsProviderElement(super.provider);

  @override
  String get brandId => (origin as BrandOutletsProvider).brandId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
