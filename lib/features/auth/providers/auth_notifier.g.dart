// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authNotifierHash() => r'1081adf4d1c6d0785f40a0f21045c7a5a882de73';

/// Manages persistent auth state for the entire app.
///
/// Consumers use `.when(data:, loading:, error:)` per CLAUDE.md §2.3.
/// The router guard watches this provider to enforce the unauthenticated → /login redirect.
///
/// On app start, [build] performs a silent token refresh; if refresh fails
/// (token expired/blacklisted) it clears storage and returns [Unauthenticated].
///
/// Copied from [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>.internal(
      AuthNotifier.new,
      name: r'authNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthNotifier = AsyncNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
