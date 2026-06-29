import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences_service.dart';
import '../domain/app_notification_entry.dart';

part 'notification_history_notifier.g.dart';

/// Persistent notification history (max [_maxItems] entries, newest first).
///
/// Entries survive app restarts via SharedPreferences. Call [add] from
/// [AppOrderWatcher] whenever a fulfillment/payment event fires.
@Riverpod(keepAlive: true)
class NotificationHistoryNotifier extends _$NotificationHistoryNotifier {
  static const _maxItems = 50;

  @override
  List<AppNotificationEntry> build() {
    _loadFromPrefs();
    return [];
  }

  Future<void> _loadFromPrefs() async {
    final raw =
        await ref.read(preferencesServiceProvider).getNotificationHistory();
    if (raw == null) return;
    try {
      final list = (jsonDecode(raw) as List<dynamic>)
          .map((e) => AppNotificationEntry.fromJson(e as Map<String, dynamic>))
          .toList();
      state = list;
    } catch (_) {}
  }

  Future<void> _persist() async {
    final encoded = jsonEncode(state.map((e) => e.toJson()).toList());
    await ref.read(preferencesServiceProvider).saveNotificationHistory(encoded);
  }

  void add(AppNotificationEntry entry) {
    final updated = [entry, ...state];
    state =
        updated.length > _maxItems ? updated.sublist(0, _maxItems) : updated;
    _persist();
  }

  void markAllRead() {
    state = [for (final e in state) e.copyWith(isRead: true)];
    _persist();
  }

  void clearAll() {
    state = [];
    _persist();
  }
}
