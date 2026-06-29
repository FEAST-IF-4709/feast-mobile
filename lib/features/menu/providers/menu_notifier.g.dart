// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$menuNotifierHash() => r'cdbda79c833fbb991268bba748f08d94cb9d9d16';

/// Fetches and holds the menu for the currently active outlet (from QR session).
///
/// Returns `null` when no QR session is active — the UI shows a
/// "Scan QR to start ordering" empty state.
///
/// Invalidate to trigger pull-to-refresh:
/// ```dart
/// ref.invalidate(menuNotifierProvider);
/// ```
///
/// Copied from [MenuNotifier].
@ProviderFor(MenuNotifier)
final menuNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      MenuNotifier,
      List<MenuCategory>?
    >.internal(
      MenuNotifier.new,
      name: r'menuNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$menuNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MenuNotifier = AutoDisposeAsyncNotifier<List<MenuCategory>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
