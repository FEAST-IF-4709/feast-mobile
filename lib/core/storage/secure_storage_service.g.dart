// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$secureStorageServiceHash() =>
    r'7229b5875cdef595f068841d7673b516523197f7';

/// Wraps flutter_secure_storage for JWT token persistence.
///
/// Access and refresh tokens MUST be stored here — never in shared_preferences
/// or plain memory (CLAUDE.md §4.1).
///
/// On Flutter Web, flutter_secure_storage_web uses AES-GCM via the browser's
/// Web Crypto API with no in-memory key cache and no mutex. Concurrent writes
/// each find localStorage empty, each generate a different AES key, and the
/// last one wins — leaving the first token encrypted under a discarded key.
/// All writes here are strictly sequential to prevent that race.
///
/// Copied from [secureStorageService].
@ProviderFor(secureStorageService)
final secureStorageServiceProvider = Provider<SecureStorageService>.internal(
  secureStorageService,
  name: r'secureStorageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageServiceRef = ProviderRef<SecureStorageService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
