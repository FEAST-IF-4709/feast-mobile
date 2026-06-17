// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'3f9cf0af0939c318fa6efc58c689c2bcbcebcdb2';

/// Single dio instance for the entire app.
///
/// Interceptor order per CLAUDE.md §3:
///   1. [AuthInterceptor]          — attaches Bearer token
///   2. [TokenRefreshInterceptor]  — handles 401 → refresh → retry; else logout
///   3. [LogInterceptor]           — debug builds only
///
/// No global tenant interceptor: outlet/brand/table IDs are passed explicitly
/// per repository call (CLAUDE.md §3.3).
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = AutoDisposeProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
