import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/outlet_repository.dart';
import '../domain/outlet.dart';
import 'location_provider.dart';

part 'brand_outlets_notifier.g.dart';

/// Maps brandId → nearest [Outlet] for the brand list screen.
///
/// One API call fetches all nearby outlets; results arrive pre-sorted
/// nearest-first, so the first outlet seen per brand is the nearest one.
/// Returns an empty map when location is unavailable.
@riverpod
Future<Map<String, Outlet>> nearestOutletPerBrand(
  NearestOutletPerBrandRef ref,
) async {
  Position? position;
  try {
    position = await ref.watch(currentLocationProvider.future);
  } catch (_) {
    position = null;
  }

  if (position == null) return {};

  final repo = ref.read(outletRepositoryProvider);
  try {
    final outlets = await repo.getNearbyAllOutlets(
      lat: position.latitude,
      lng: position.longitude,
    );
    final map = <String, Outlet>{};
    for (final outlet in outlets) {
      if (outlet.brandId != null && !map.containsKey(outlet.brandId)) {
        map[outlet.brandId!] = outlet;
      }
    }
    return map;
  } catch (_) {
    return {};
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
@riverpod
Future<List<Outlet>> brandOutlets(
  BrandOutletsRef ref,
  String brandId,
) async {
  // currentLocationProvider is documented as non-throwing, but we guard here
  // in case any unexpected platform error escapes (e.g. Geolocator edge cases).
  Position? position;
  try {
    position = await ref.watch(currentLocationProvider.future);
  } catch (_) {
    position = null;
  }

  final repo = ref.read(outletRepositoryProvider);

  if (position != null) {
    try {
      return await repo.getNearbyOutlets(
        lat: position.latitude,
        lng: position.longitude,
        brandId: brandId,
      );
    } catch (_) {
      // Nearby endpoint unavailable — fall back to full list
    }
  }

  return repo.getAllOutlets(brandId: brandId);
}
