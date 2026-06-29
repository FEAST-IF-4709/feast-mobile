import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/constants/env.dart';
import '../../../core/router/app_routes.dart';
import '../../../features/auth/providers/auth_notifier.dart';
import '../../../features/loyalty/providers/loyalty_notifier.dart';
import '../domain/customer_profile.dart';
import '../providers/profile_notifier.dart';

/// Halaman profil customer — menggantikan lib/pages/profiles.dart.
/// Data nyata dari GET /api/v1/customers/me/ via [profileNotifierProvider].
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F1),
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 12),
                Text(
                  'Gagal memuat profil.',
                  style: GoogleFonts.inter(color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ref.invalidate(profileNotifierProvider),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
          data: (profile) => _ProfileBody(profile: profile),
        ),
      ),
    );
  }
}

class _ProfileBody extends ConsumerWidget {
  const _ProfileBody({required this.profile});

  final CustomerProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loyalty = ref.watch(loyaltyAccountProvider).valueOrNull;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (Navigator.canPop(context))
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                )
              else
                const SizedBox(width: 40),
              Text(
                'Profil',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: 20),

          // PROFILE CARD
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _ProfileAvatar(profile: profile),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (profile.email != null)
                        Text(
                          profile.email!,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      const SizedBox(height: 12),
                      // Tier badge — placeholder hingga M8
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade400,
                              Colors.grey.shade200,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.workspace_premium,
                                size: 14, color: Colors.grey.shade700),
                            const SizedBox(width: 6),
                            Text(
                              loyalty != null
                                  ? _tierLabel(loyalty.tier)
                                  : 'FEAST Member',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.editProfile),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFEFE3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit,
                        color: AppColors.primary, size: 18),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // REWARDS CARD — visual dipertahankan untuk M8
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE8D7B3),
                  Color(0xFFD9B58A),
                  Color(0xFFEED9B5),
                  Color(0xFFD7B18A),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(Icons.star_border_rounded,
                      size: 40, color: Colors.amber.shade700),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FEAST Rewards',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Poin loyalty Anda',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // M8 wires real balance
                            Text(
                              loyalty != null
                                  ? '${loyalty.pointsBalance}'
                                  : '--',
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'POINTS BALANCE',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 10,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ACCOUNT & SETTINGS
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACCOUNT & SETTINGS',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.brown.shade700,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                _MenuItem(
                  icon: Icons.person_outline,
                  title: 'Informasi Pribadi',
                  onTap: () => context.push(AppRoutes.personalInfo),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // LOGOUT
          GestureDetector(
            onTap: () => _confirmLogout(context, ref),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE0E0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.red.shade800, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Keluar',
                    style: GoogleFonts.inter(
                      color: Colors.red.shade800,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Keluar', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        content: Text('Yakin ingin keluar dari akun?', style: GoogleFonts.inter()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Keluar',
                style: TextStyle(color: Colors.red.shade700)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(authNotifierProvider.notifier).logout();
      // Invalidate profile cache so next login fetches fresh data.
      ref.invalidate(profileNotifierProvider);
      // Router guard detects AuthState.unauthenticated and redirects to login.
    }
  }

  static String _tierLabel(String tier) => switch (tier) {
        'GOLD' => 'Gold Member',
        'SILVER' => 'Silver Member',
        _ => 'Bronze Member',
      };
}

/// Avatar widget: shows local optimistic file path, then network photo, then placeholder.
class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.profile});

  final CustomerProfile profile;

  @override
  Widget build(BuildContext context) {
    final size = 60.0;

    Widget child;
    if (profile.localPhotoPath != null) {
      child = CircleAvatar(
        radius: size / 2,
        backgroundImage: FileImage(File(profile.localPhotoPath!)),
      );
    } else {
      final url = _resolveUrl(profile.profilePhotoUrl);
      if (url.isNotEmpty) {
        child = CircleAvatar(
          radius: size / 2,
          backgroundImage: CachedNetworkImageProvider(url),
        );
      } else {
        child = CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.person, size: 30, color: Colors.grey),
        );
      }
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2.5),
      ),
      child: ClipOval(child: child),
    );
  }

  String _resolveUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    return '$kApiBaseUrl$raw';
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF1E8),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.orange.shade800, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.brown.shade300),
        ],
      ),
    );
  }
}
