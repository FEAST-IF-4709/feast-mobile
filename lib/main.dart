import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/notifications/services/push_notification_service.dart';
import 'shared/widgets/app_order_watcher.dart';
import 'shared/widgets/notification_overlay.dart';
import 'shared/widgets/push_notification_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase belum dikonfigurasi (google-services.json belum ada).
    // App tetap berjalan; push notification tidak aktif.
  }
  runApp(const ProviderScope(child: FeastApp()));
}

class FeastApp extends ConsumerWidget {
  const FeastApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    // Give the service a router reference so tapped notifications can navigate.
    PushNotificationService.setRouter(router);
    return MaterialApp.router(
      title: 'FEAST',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
      builder: (context, child) => Stack(
        children: [
          child!,
          // Keeps OrderTrackingNotifier alive and feeds notification history.
          const AppOrderWatcher(),
          // Initialises FCM token after login, cleans up on logout.
          const PushNotificationListener(),
          // In-app notification banner — rendered above everything.
          const NotificationOverlay(),
        ],
      ),
    );
  }
}
