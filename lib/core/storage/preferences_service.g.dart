// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$preferencesServiceHash() =>
    r'9de12464b4a374f9267262d9949b4ee0da53f5bd';

/// Wraps shared_preferences for non-sensitive, non-token data.
///
/// Allowed: cart draft JSON, last QR session cache, UI preferences.
/// Never store access/refresh tokens here — use [SecureStorageService] instead
/// (CLAUDE.md §4.1).
///
/// Copied from [preferencesService].
@ProviderFor(preferencesService)
final preferencesServiceProvider = Provider<PreferencesService>.internal(
  preferencesService,
  name: r'preferencesServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$preferencesServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreferencesServiceRef = ProviderRef<PreferencesService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
