import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/widgets/app_order_watcher.dart';
import 'shared/widgets/notification_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const ProviderScope(child: FeastApp()));
}

class FeastApp extends ConsumerWidget {
  const FeastApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'FEAST',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
      builder: (context, child) => Stack(
        children: [
          child!,
          // Keeps OrderTrackingNotifier alive across all screens so the
          // WebSocket stays connected and notifications fire app-wide.
          const AppOrderWatcher(),
          // In-app notification banner — rendered above everything.
          const NotificationOverlay(),
        ],
      ),
    );
  }
}
