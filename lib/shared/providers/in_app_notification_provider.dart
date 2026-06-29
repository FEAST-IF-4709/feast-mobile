import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_app_notification_provider.g.dart';

/// Data for a single in-app notification bubble.
///
/// [brandName] and [brandLogoUrl] are sourced from the active [TableSession]
/// so the banner shows the brand the customer is currently ordering from
/// instead of a generic "FEAST" header.
class AppNotification {
  AppNotification({
    required this.title,
    required this.body,
    this.brandName,
    this.brandLogoUrl,
    DateTime? shownAt,
  }) : shownAt = shownAt ?? DateTime.now();

  final String title;
  final String body;

  /// Brand name displayed in the notification header (e.g. "Kopi Senja").
  final String? brandName;

  /// Brand logo URL for the notification icon. Falls back to a letter avatar
  /// when null.
  final String? brandLogoUrl;

  /// Client-side timestamp used to render the relative "Just now" label.
  final DateTime shownAt;
}

/// Global in-app notification state.
///
/// Call [show] from any notifier (e.g. [OrderTrackingNotifier]) to surface a
/// banner. The banner auto-dismisses after 4 seconds; [dismiss] removes it
/// immediately (e.g. on swipe or tap).
@Riverpod(keepAlive: true)
class InAppNotificationNotifier extends _$InAppNotificationNotifier {
  Timer? _dismissTimer;

  @override
  AppNotification? build() {
    ref.onDispose(() => _dismissTimer?.cancel());
    return null;
  }

  void show(AppNotification notification) {
    _dismissTimer?.cancel();
    state = notification;
    _dismissTimer = Timer(const Duration(seconds: 4), dismiss);
  }

  void dismiss() {
    _dismissTimer?.cancel();
    state = null;
  }
}
