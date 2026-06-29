// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_logout_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$forceLogoutNotifierHash() =>
    r'4a07a4b7b3ff833058bdbf28738faad2942ae9ca';

/// Monotonically incrementing counter; the token-refresh interceptor increments
/// this when an unrecoverable 401 is received (refresh token also invalid).
///
/// [AuthNotifier] watches this to trigger a rebuild that re-checks token
/// storage (which will be empty) and returns [AuthState.unauthenticated].
///
/// Copied from [ForceLogoutNotifier].
@ProviderFor(ForceLogoutNotifier)
final forceLogoutNotifierProvider =
    NotifierProvider<ForceLogoutNotifier, int>.internal(
      ForceLogoutNotifier.new,
      name: r'forceLogoutNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$forceLogoutNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ForceLogoutNotifier = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
