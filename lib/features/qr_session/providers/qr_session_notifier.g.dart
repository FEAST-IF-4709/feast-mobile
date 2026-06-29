// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$qrSessionNotifierHash() => r'6dfa0475cc351dbfeb43f140bf1f7bf87a3688a8';

/// Manages the active table/outlet session derived from a scanned QR code.
///
/// State is `null` when no QR has been scanned (or after logout/clear).
/// State is a [TableSession] when a valid token has been resolved and stored.
///
/// On app start [build] restores the last session from SharedPreferences so
/// the user does not need to re-scan on every launch.
///
/// ## Usage by downstream features (M4+)
///
/// Read outlet/brand/table context and pass **explicitly** as repository params:
///
/// ```dart
/// final session = ref.watch(qrSessionNotifierProvider).requireValue!;
/// await menuRepo.fetchMenu(outletId: session.outletId);
/// ```
///
/// Never inject outlet/brand/table IDs via a global interceptor or header
/// (CLAUDE.md §3.3).
///
/// Copied from [QrSessionNotifier].
@ProviderFor(QrSessionNotifier)
final qrSessionNotifierProvider =
    AsyncNotifierProvider<QrSessionNotifier, TableSession?>.internal(
      QrSessionNotifier.new,
      name: r'qrSessionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$qrSessionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$QrSessionNotifier = AsyncNotifier<TableSession?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
