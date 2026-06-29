import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../features/auth/domain/auth_state.dart';
import '../../features/auth/providers/auth_notifier.dart';
import '../../features/notifications/services/push_notification_service.dart';

/// Invisible widget that initialises FCM after login and cleans up on logout.
/// Mount once at the app root inside [MaterialApp.router]'s builder.
class PushNotificationListener extends ConsumerStatefulWidget {
  const PushNotificationListener({super.key});

  @override
  ConsumerState<PushNotificationListener> createState() =>
      _PushNotificationListenerState();
}

class _PushNotificationListenerState
    extends ConsumerState<PushNotificationListener> {
  bool _initialised = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthState>>(
      authNotifierProvider,
      (previous, next) {
        final prevAuthenticated =
            previous?.valueOrNull is Authenticated;
        final nextState = next.valueOrNull;

        if (nextState is Authenticated && !prevAuthenticated && !_initialised) {
          _initialised = true;
          final dio = ref.read(dioProvider);
          PushNotificationService.init(dio).catchError((_) {
            // Firebase belum dikonfigurasi — abaikan error push notification.
          });
        }

        if (nextState is Unauthenticated && prevAuthenticated) {
          _initialised = false;
          final dio = ref.read(dioProvider);
          PushNotificationService.deleteToken(dio).catchError((_) {});
        }
      },
    );

    return const SizedBox.shrink();
  }
}
