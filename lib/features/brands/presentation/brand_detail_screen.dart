import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../domain/brand.dart';
import '../domain/outlet.dart';
import '../providers/brand_outlets_notifier.dart';

class BrandDetailScreen extends ConsumerWidget {
  final Brand brand;

  const BrandDetailScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outletsAsync = ref.watch(brandOutletsProvider(brand.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back,
                    color: Colors.white, size: 20),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _BrandBanner(brand: brand),
            ),
          ),

          // Brand info card
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LogoCircle(brand: brand),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              brand.name,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            if (brand.cuisineType != null) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  brand.cuisineType!.toUpperCase(),
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (brand.description != null) ...[
                    const SizedBox(height: 14),
                    Text(
                      brand.description!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                  if (brand.operatingHours != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 6),
                        Text(
                          brand.operatingHours!,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // Outlet section header — label shows distance when location is on,
          // falls back to name-sorted list when location is off.
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text(
                'Outlet',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Outlet list
          outletsAsync.when(
            loading: () =>
                const SliverToBoxAdapter(child: _OutletSkeletonList()),
            error: (_, _) => SliverToBoxAdapter(
              child: _ErrorCard(
                onRetry: () => ref.invalidate(brandOutletsProvider(brand.id)),
              ),
            ),
            data: (outlets) {
              if (outlets.isEmpty) {
                return SliverToBoxAdapter(child: _EmptyCard(brand: brand));
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _OutletCard(
                    outlet: outlets[i],
                    onOrder: () => context.push(AppRoutes.qrScan),
                  ),
                  childCount: outlets.length,
                ),
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

// ── Banner ─────────────────────────────────────────────────────────────────

class _BrandBanner extends StatelessWidget {
  final Brand brand;

  const _BrandBanner({required this.brand});

  @override
  Widget build(BuildContext context) {
    final imageUrl = brand.bannerUrl ?? brand.logoUrl;
    if (imageUrl != null) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, _, _) => _fallback(),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE07B00), Color(0xFFF59E0B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant_menu,
          size: 64,
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

// ── Logo circle ────────────────────────────────────────────────────────────

class _LogoCircle extends StatelessWidget {
  final Brand brand;

  const _LogoCircle({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF1DDD1), width: 1.5),
        color: const Color(0xFFF5E6D8),
      ),
      child: ClipOval(
        child: brand.logoUrl != null
            ? Image.network(
                brand.logoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Center(
                  child: Icon(Icons.restaurant,
                      size: 28, color: AppColors.primary),
                ),
              )
            : const Center(
                child: Icon(Icons.restaurant,
                    size: 28, color: AppColors.primary),
              ),
      ),
    );
  }
}

// ── Outlet card ────────────────────────────────────────────────────────────

class _OutletCard extends StatelessWidget {
  final Outlet outlet;
  final VoidCallback onOrder;

  const _OutletCard({required this.outlet, required this.onOrder});

  @override
  Widget build(BuildContext context) {
    final distLabel = outlet.distanceKm != null
        ? outlet.distanceKm! < 1
            ? '${(outlet.distanceKm! * 1000).round()} m'
            : '${outlet.distanceKm!.toStringAsFixed(1)} km'
        : null;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            outlet.name,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              if (distLabel != null) ...[
                Icon(Icons.near_me_rounded,
                    size: 13, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  distLabel,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                if (outlet.address != null) ...[
                  Text(
                    '  •  ',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey.shade400),
                  ),
                ],
              ],
              if (outlet.address != null)
                Expanded(
                  child: Text(
                    outlet.address!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 48),
                elevation: 0,
              ),
              child: Text(
                'Pesan Sekarang',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── States ─────────────────────────────────────────────────────────────────

class _EmptyCard extends StatelessWidget {
  final Brand brand;

  const _EmptyCard({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1DDD1)),
      ),
      child: Text(
        'Belum ada outlet ${brand.name} yang tersedia.',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorCard({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1DDD1)),
      ),
      child: Column(
        children: [
          Icon(Icons.wifi_off_rounded, size: 40, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'Gagal memuat outlet.\nPeriksa koneksi kamu.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 13, color: Colors.grey.shade600, height: 1.4),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Coba lagi',
              style: GoogleFonts.inter(
                  color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _OutletSkeletonList extends StatelessWidget {
  const _OutletSkeletonList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (_) => const _OutletSkeleton()),
    );
  }
}

class _OutletSkeleton extends StatelessWidget {
  const _OutletSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 16, width: 160, color: Colors.grey.shade200),
          const SizedBox(height: 8),
          Container(height: 12, width: 220, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
