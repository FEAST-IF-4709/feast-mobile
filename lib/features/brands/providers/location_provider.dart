import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';

part 'location_provider.g.dart';

/// Manages device location with persistent fallback.
///
/// On every cold start, requests fresh location and persists it to
/// [PreferencesService]. If permission is denied or GPS unavailable,
/// returns the last saved location instead of null. Only returns null
/// when the user has never granted location access.
@Riverpod(keepAlive: true)
class CurrentLocation extends _$CurrentLocation {
  @override
  Future<Position?> build() async {
    final prefs = ref.read(preferencesServiceProvider);

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return _loadSaved(prefs);

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return _loadSaved(prefs);
    }
    if (permission == LocationPermission.deniedForever) return _loadSaved(prefs);

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
      await prefs.saveLocation(position.latitude, position.longitude);
      return position;
    } catch (_) {
      return _loadSaved(prefs);
    }
  }

  Future<Position?> _loadSaved(PreferencesService prefs) async {
    final saved = await prefs.getSavedLocation();
    if (saved == null) return null;
    return Position(
      latitude: saved.$1,
      longitude: saved.$2,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
}

/// Haversine distance in metres between two lat/lng pairs.
double distanceMetres(
  double lat1,
  double lng1,
  double lat2,
  double lng2,
) =>
    Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
