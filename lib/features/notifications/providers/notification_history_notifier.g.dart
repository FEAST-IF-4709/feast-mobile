// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationHistoryNotifierHash() =>
    r'9490f4b61074056c5b113cdc7e5521487715cbbb';

/// Persistent notification history (max [_maxItems] entries, newest first).
///
/// Entries survive app restarts via SharedPreferences. Call [add] from
/// [AppOrderWatcher] whenever a fulfillment/payment event fires.
///
/// Copied from [NotificationHistoryNotifier].
@ProviderFor(NotificationHistoryNotifier)
final notificationHistoryNotifierProvider =
    NotifierProvider<
      NotificationHistoryNotifier,
      List<AppNotificationEntry>
    >.internal(
      NotificationHistoryNotifier.new,
      name: r'notificationHistoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationHistoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationHistoryNotifier = Notifier<List<AppNotificationEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
