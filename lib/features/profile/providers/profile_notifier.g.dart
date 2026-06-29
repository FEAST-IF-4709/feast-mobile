// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileNotifierHash() => r'be2704b7a897d96e92fc1e3503ea7c9a28ee3ab9';

/// Manages the authenticated customer's profile state.
///
/// keepAlive: true — prevents re-fetch on every tab switch.
/// Invalidate via [ref.invalidate(profileNotifierProvider)] after logout or
/// if a fresh fetch is needed.
///
/// Copied from [ProfileNotifier].
@ProviderFor(ProfileNotifier)
final profileNotifierProvider =
    AsyncNotifierProvider<ProfileNotifier, CustomerProfile>.internal(
      ProfileNotifier.new,
      name: r'profileNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileNotifier = AsyncNotifier<CustomerProfile>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
