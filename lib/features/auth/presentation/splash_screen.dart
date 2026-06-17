import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/brands/providers/location_provider.dart';
import '../domain/auth_state.dart';
import '../providers/auth_notifier.dart';

/// Bootstrap screen — shown while [AuthNotifier] performs the silent token refresh.
///
/// Navigates automatically once auth resolves:
///   - Unauthenticated → /login
///   - Authenticated → /home  (QR scan is triggered per-flow, not globally)
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger location fetch immediately on app open so the permission dialog
    // appears during splash and the result is cached for the rest of the session.
    ref.watch(currentLocationProvider);

    ref.listen<AsyncValue<AuthState>>(
      authNotifierProvider,
      (_, _) => _tryNavigate(context, ref),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFFFF2E6)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'FEAST',
                style: GoogleFonts.inter(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: FeastColors.primary,
                  letterSpacing: 4.0,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: FeastColors.primary.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tryNavigate(BuildContext context, WidgetRef ref) {
    if (!context.mounted) return;

    final authAsync = ref.read(authNotifierProvider);
    if (authAsync.isLoading) return;

    authAsync.whenOrNull(
      error: (_, _) => context.go(AppRoutes.login),
      data: (authState) {
        switch (authState) {
          case Unauthenticated():
            context.go(AppRoutes.login);
          case Authenticated():
            context.go(AppRoutes.home);
        }
      },
    );
  }
}
