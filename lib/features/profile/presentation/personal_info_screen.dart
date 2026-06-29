import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/constants/env.dart';
import '../domain/customer_profile.dart';
import '../providers/profile_notifier.dart';

/// Read-only display of name, email, phone dari API.
/// DOB dan gender dihapus — tidak dikembalikan backend profile endpoint.
class PersonalInfoScreen extends ConsumerWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Informasi Pribadi',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text('Gagal memuat data.',
                  style: GoogleFonts.inter(color: Colors.grey[600])),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => ref.invalidate(profileNotifierProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
        data: (profile) => _PersonalInfoBody(profile: profile),
      ),
    );
  }
}

class _PersonalInfoBody extends StatelessWidget {
  const _PersonalInfoBody({required this.profile});

  final CustomerProfile profile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top profile summary card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                _MiniAvatar(profile: profile),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (profile.email != null)
                        Text(
                          profile.email!,
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.workspace_premium,
                                size: 13, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'FEAST Member',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'DETAIL AKUN',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 14),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.person_outline,
                  label: 'Nama Lengkap',
                  value: profile.fullName,
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                _DetailRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: profile.email ?? '-',
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                _DetailRow(
                  icon: Icons.phone_outlined,
                  label: 'Nomor Telepon',
                  value: profile.phone,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar({required this.profile});
  final CustomerProfile profile;

  @override
  Widget build(BuildContext context) {
    if (profile.localPhotoPath != null) {
      return CircleAvatar(
        radius: 28,
        backgroundImage: FileImage(File(profile.localPhotoPath!)),
      );
    }
    final url = _resolve(profile.profilePhotoUrl);
    if (url.isNotEmpty) {
      return CircleAvatar(
        radius: 28,
        backgroundImage: CachedNetworkImageProvider(url),
      );
    }
    return CircleAvatar(
      radius: 28,
      backgroundColor: Colors.grey.shade200,
      child: const Icon(Icons.person, color: Colors.grey),
    );
  }

  String _resolve(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    return '$kApiBaseUrl$raw';
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        label,
        style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 11),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
