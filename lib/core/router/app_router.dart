import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth presentation screens (Fase M2)
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/domain/auth_state.dart';
import '../../features/auth/providers/auth_notifier.dart';

// QR session (Fase M3)
import '../../features/qr_session/presentation/scan_qr_screen.dart';

// Menu + Cart + Payment (Fase M4/M5)
import '../../features/menu/domain/menu_item.dart';
import '../../features/menu/presentation/menu_screen.dart';
import '../../features/menu/presentation/item_detail_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/checkout/presentation/payment_screen.dart';

// Order Tracking (Fase M6)
import '../../features/order_tracking/presentation/order_tracking_screen.dart';

// Order History (Fase M7)
import '../../features/order_history/presentation/order_history_screen.dart';
import '../../features/order_history/presentation/order_detail_screen.dart';

// Notifications (F2)
import '../../features/notifications/presentation/notification_list_screen.dart';

// Profile (Fase M7)
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../features/profile/presentation/personal_info_screen.dart';

import '../../features/brands/domain/brand.dart';
import '../../features/brands/presentation/brand_detail_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/membership_screen.dart';
import '../../features/loyalty/presentation/rewards_screen.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

/// Routes that unauthenticated users may access.
const _publicRoutes = {
  AppRoutes.splash,
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.qrScan,
};

/// Bridges Riverpod auth state changes to go_router's redirect mechanism.
///
/// Created once inside [appRouterProvider] via [ref.listen]; go_router calls
/// [redirect] each time this [ChangeNotifier] fires.
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<AuthState>>(
      authNotifierProvider,
      (_, _) => notifyListeners(),
    );
  }

  final Ref _ref;

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final authAsync = _ref.read(authNotifierProvider);

    // Don't redirect while auth is loading (splash spinner handles it).
    if (authAsync.isLoading) return null;

    final isAuthenticated =
        authAsync.valueOrNull?.whenOrNull(authenticated: (_, _) => true) ??
            false;

    final location = state.matchedLocation;

    if (_publicRoutes.contains(location)) return null;
    if (!isAuthenticated) return AppRoutes.login;

    // QR scan is not a global gate — it is triggered per-flow (navbar button
    // or restaurant selection). Authenticated users always reach home first.
    return null;
  }
}

/// Centralised go_router instance (CLAUDE.md §5).
///
/// The [_RouterNotifier] listens to [authNotifierProvider] and tells go_router
/// to re-evaluate redirects on every auth state change without recreating the
/// [GoRouter] itself.
@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final notifier = _RouterNotifier(ref);
  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: (ctx, state) => notifier.redirect(ctx, state),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.qrScan,
        name: 'qrScan',
        builder: (_, _) => const ScanQrScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (_, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        // TODO(M7): pass real customer name from authNotifierProvider
        builder: (_, _) => const HomeScreen(username: 'guest'),
      ),
      GoRoute(
        path: AppRoutes.menu,
        name: 'menu',
        builder: (_, _) => const MenuScreen(),
      ),
      GoRoute(
        path: AppRoutes.itemDetail,
        name: 'itemDetail',
        builder: (_, state) =>
            ItemDetailScreen(item: state.extra as MenuItem),
      ),
      GoRoute(
        path: AppRoutes.cart,
        name: 'cart',
        builder: (_, _) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.payment,
        name: 'payment',
        builder: (_, state) {
          final extra = state.extra as Map<String, String>;
          return PaymentScreen(
            orderId: state.pathParameters['orderId']!,
            orderNumber: extra['orderNumber']!,
            subtotal: extra['subtotal']!,
            discountTotal: extra['discountTotal']!,
            taxAmount: extra['taxAmount']!,
            grandTotal: extra['grandTotal']!,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.orderTracking,
        name: 'orderTracking',
        builder: (_, state) {
          final extra = state.extra as Map<String, String?>?;
          return OrderTrackingScreen(
            orderId: state.pathParameters['orderId']!,
            orderNumber: extra?['orderNumber'],
          );
        },
      ),
      GoRoute(
        path: AppRoutes.orderHistory,
        name: 'orderHistory',
        builder: (_, _) => const OrderHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.orderDetail,
        name: 'orderDetail',
        builder: (_, state) => OrderDetailScreen(
          orderId: state.pathParameters['orderId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (_, _) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: 'editProfile',
        builder: (_, _) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.personalInfo,
        name: 'personalInfo',
        builder: (_, _) => const PersonalInfoScreen(),
      ),
      GoRoute(
        path: AppRoutes.membership,
        name: 'membership',
        builder: (_, _) => MembershipScreen(),
      ),
      GoRoute(
        path: AppRoutes.rewards,
        name: 'rewards',
        builder: (_, _) => const RewardsScreen(),
      ),
      GoRoute(
        path: AppRoutes.brandDetail,
        name: 'brandDetail',
        builder: (_, state) => BrandDetailScreen(
          brand: state.extra as Brand,
        ),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        builder: (_, _) => const NotificationListScreen(),
      ),
    ],
  );
}

