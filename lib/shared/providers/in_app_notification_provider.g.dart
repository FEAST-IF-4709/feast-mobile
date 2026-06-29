// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inAppNotificationNotifierHash() =>
    r'b4c32ac413fcda888a87d4cfed8dfebedd4f72c3';

/// Global in-app notification state.
///
/// Call [show] from any notifier (e.g. [OrderTrackingNotifier]) to surface a
/// banner. The banner auto-dismisses after 4 seconds; [dismiss] removes it
/// immediately (e.g. on swipe or tap).
///
/// Copied from [InAppNotificationNotifier].
@ProviderFor(InAppNotificationNotifier)
final inAppNotificationNotifierProvider =
    NotifierProvider<InAppNotificationNotifier, AppNotification?>.internal(
      InAppNotificationNotifier.new,
      name: r'inAppNotificationNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inAppNotificationNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InAppNotificationNotifier = Notifier<AppNotification?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
