import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/menu_repository.dart';
import '../domain/menu_item.dart';
import '../../qr_session/providers/qr_session_notifier.dart';

part 'menu_notifier.g.dart';

/// Fetches and holds the menu for the currently active outlet (from QR session).
///
/// Returns `null` when no QR session is active — the UI shows a
/// "Scan QR to start ordering" empty state.
///
/// Invalidate to trigger pull-to-refresh:
/// ```dart
/// ref.invalidate(menuNotifierProvider);
/// ```
@riverpod
class MenuNotifier extends _$MenuNotifier {
  @override
  Future<List<MenuCategory>?> build() async {
    final session = await ref.watch(qrSessionNotifierProvider.future);
    if (session == null) return null;
    return ref.read(menuRepositoryProvider).getMenu(session.outletId);
  }
}
