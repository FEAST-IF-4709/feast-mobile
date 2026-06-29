import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';
import '../data/qr_session_repository.dart';
import '../domain/table_session.dart';

part 'qr_session_notifier.g.dart';

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
@Riverpod(keepAlive: true)
class QrSessionNotifier extends _$QrSessionNotifier {
  @override
  Future<TableSession?> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    final stored = await prefs.getLastQrSession();
    if (stored == null) return null;
    try {
      return TableSession.fromJson(jsonDecode(stored) as Map<String, dynamic>);
    } catch (_) {
      // Corrupt or schema-incompatible stored data — treat as no session.
      await prefs.clearQrSession();
      return null;
    }
  }

  /// Resolves [qrToken] via the backend, persists the session, and updates
  /// state. Throws [ApiException] on invalid/expired token — the scan screen
  /// catches this and shows an inline error without navigating away.
  Future<void> resolveToken(String qrToken) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session =
          await ref.read(qrSessionRepositoryProvider).resolveToken(qrToken);
      await ref
          .read(preferencesServiceProvider)
          .saveLastQrSession(jsonEncode(session.toJson()));
      return session;
    });
  }

  /// Clears the active session from state and persistent storage.
  ///
  /// Called by [AuthNotifier.logout] so a new scan is required after
  /// signing back in (CLAUDE.md §4.3).
  Future<void> clearSession() async {
    await ref.read(preferencesServiceProvider).clearQrSession();
    state = const AsyncData(null);
  }
}
