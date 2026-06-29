// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentLocationHash() => r'1c572591ae02289d020479af705b9abb3c46d3dd';

/// Manages device location with persistent fallback.
///
/// On every cold start, requests fresh location and persists it to
/// [PreferencesService]. If permission is denied or GPS unavailable,
/// returns the last saved location instead of null. Only returns null
/// when the user has never granted location access.
///
/// Copied from [CurrentLocation].
@ProviderFor(CurrentLocation)
final currentLocationProvider =
    AsyncNotifierProvider<CurrentLocation, Position?>.internal(
      CurrentLocation.new,
      name: r'currentLocationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentLocationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentLocation = AsyncNotifier<Position?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
