import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../domain/brand.dart';
import '../domain/outlet.dart';
import '../providers/brand_notifier.dart';
import '../providers/brand_outlets_notifier.dart';
import '../providers/location_provider.dart';

enum _SortMode { name, distance }

class BrandsScreen extends ConsumerStatefulWidget {
  const BrandsScreen({super.key});

  @override
  ConsumerState<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends ConsumerState<BrandsScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  _SortMode _sortMode = _SortMode.name;
  bool _autoSwitchedToDistance = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onSortChanged(
    _SortMode mode,
    AsyncValue<Position?> locationAsync,
  ) async {
    if (mode == _SortMode.distance) {
      // Already have a fix — just switch
      if (locationAsync.valueOrNull != null) {
        setState(() => _sortMode = _SortMode.distance);
        return;
      }

      // Still fetching — wait; listener will auto-switch when it resolves
      if (locationAsync.isLoading) return;

      // Location is null — find out why and guide the user
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Aktifkan GPS untuk sort berdasarkan jarak.'),
            action: SnackBarAction(
              label: 'Buka Pengaturan',
              onPressed: Geolocator.openLocationSettings,
            ),
          ),
        );
        return;
      }

      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Izin lokasi diblokir. Buka pengaturan aplikasi.'),
            action: SnackBarAction(
              label: 'Pengaturan',
              onPressed: Geolocator.openAppSettings,
            ),
          ),
        );
        return;
      }

      // Permission belum diberikan — invalidate agar provider minta ulang
      ref.invalidate(currentLocationProvider);
      return;
    }

    setState(() => _sortMode = mode);
  }

  List<Brand> _sorted(
    List<Brand> brands,
    Map<String, Outlet> nearestOutlets,
  ) {
    final q = _query.toLowerCase();
    final filtered = q.isEmpty
        ? brands
        : brands
            .where((b) {
              final outletAddress =
                  nearestOutlets[b.id]?.address?.toLowerCase() ?? '';
              return b.name.toLowerCase().contains(q) ||
                  (b.cuisineType?.toLowerCase().contains(q) ?? false) ||
                  outletAddress.contains(q);
            })
            .toList();

    if (_sortMode == _SortMode.distance) {
      filtered.sort((a, b) {
        final da = nearestOutlets[a.id]?.distanceKm ?? double.infinity;
        final db = nearestOutlets[b.id]?.distanceKm ?? double.infinity;
        return da.compareTo(db);
      });
    } else {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final brandsAsync = ref.watch(brandNotifierProvider);
    final locationAsync = ref.watch(currentLocationProvider);
    final nearestOutlets =
        ref.watch(nearestOutletPerBrandProvider).valueOrNull ?? {};

    // Auto-switch to distance as soon as location is available — covers both
    // the case where it's already resolved (cached) and when it arrives later.
    if (!_autoSwitchedToDistance && locationAsync.valueOrNull != null) {
      _autoSwitchedToDistance = true;
      _sortMode = _SortMode.distance;
    }

    // Handles location arriving asynchronously after first build.
    ref.listen(currentLocationProvider, (_, next) {
      if (!_autoSwitchedToDistance && next.valueOrNull != null) {
        _autoSwitchedToDistance = true;
        setState(() => _sortMode = _SortMode.distance);
      }
    });

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Brand',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                // Sort toggle
                _SortToggle(
                  current: _sortMode,
                  locationAvailable: locationAsync.valueOrNull != null,
                  locationLoading: locationAsync.isLoading,
                  onChanged: (mode) => _onSortChanged(mode, locationAsync),
                ),
              ],
            ),
          ),

          // ── Search bar ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              style: GoogleFonts.inter(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Cari brand atau masakan…',
                hintStyle: GoogleFonts.inter(
                    fontSize: 14, color: Colors.grey.shade400),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: Colors.grey, size: 20),
                suffixIcon: _query.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        child: const Icon(Icons.close_rounded,
                            color: Colors.grey, size: 18),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFF1DDD1)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFF1DDD1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
          ),

          // ── List ────────────────────────────────────────────────────────────
          Expanded(
            child: brandsAsync.when(
              loading: () => ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                itemCount: 4,
                itemBuilder: (_, _) => const _BrandCardSkeleton(),
              ),
              error: (_, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off_rounded,
                          size: 48, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Gagal memuat brand.\nPeriksa koneksi kamu.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () =>
                            ref.invalidate(brandNotifierProvider),
                        child: Text(
                          'Coba lagi',
                          style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              data: (brands) {
                final sorted = _sorted(brands, nearestOutlets);

                if (sorted.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        _query.isNotEmpty
                            ? 'Tidak ada brand yang cocok dengan "$_query"'
                            : 'Belum ada brand tersedia.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                  physics: const BouncingScrollPhysics(),
                  itemCount: sorted.length,
                  itemBuilder: (context, i) => _BrandCard(
                    brand: sorted[i],
                    nearestOutlet: nearestOutlets[sorted[i].id],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sort toggle chip ──────────────────────────────────────────────────────────

class _SortToggle extends StatelessWidget {
  final _SortMode current;
  final bool locationAvailable;
  final bool locationLoading;
  final ValueChanged<_SortMode> onChanged;

  const _SortToggle({
    required this.current,
    required this.locationAvailable,
    required this.locationLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1DDD1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Chip(
            label: 'Nama',
            icon: Icons.sort_by_alpha_rounded,
            active: current == _SortMode.name,
            onTap: () => onChanged(_SortMode.name),
          ),
          _Chip(
            label: locationLoading ? 'Lokasi…' : 'Terdekat',
            icon: locationLoading
                ? Icons.location_searching_rounded
                : Icons.near_me_rounded,
            active: current == _SortMode.distance,
            onTap: () => onChanged(_SortMode.distance),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 14, color: active ? Colors.white : Colors.grey.shade500),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Brand card ────────────────────────────────────────────────────────────────

class _BrandCard extends StatelessWidget {
  final Brand brand;
  final Outlet? nearestOutlet;

  const _BrandCard({required this.brand, this.nearestOutlet});

  @override
  Widget build(BuildContext context) {
    final distanceLabel = _buildDistanceLabel();

    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.brandDetail.replaceFirst(':brandId', brand.id),
        extra: brand,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: _brandImage(),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (brand.isBusyMode)
                        _StatusBadge(
                            label: 'Sibuk', color: Colors.orange.shade600),
                      if (!brand.isAcceptingOrders) ...[
                        if (brand.isBusyMode) const SizedBox(width: 6),
                        _StatusBadge(
                            label: 'Tutup', color: Colors.red.shade600),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (brand.logoUrl != null)
                    Container(
                      width: 44,
                      height: 44,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFF1DDD1), width: 1.5),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          brand.logoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Center(
                            child: Icon(Icons.restaurant,
                                size: 22, color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brand.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        if (brand.cuisineType != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            brand.cuisineType!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        if (nearestOutlet?.address != null) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  size: 13, color: Colors.grey.shade500),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  nearestOutlet!.address!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              if (distanceLabel != null) ...[
                                const SizedBox(width: 6),
                                Text(
                                  distanceLabel,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ] else if (distanceLabel != null) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.near_me_rounded,
                                  size: 13, color: AppColors.primary),
                              const SizedBox(width: 3),
                              Text(
                                distanceLabel,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (brand.operatingHours != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time_rounded,
                                  size: 13, color: Colors.grey.shade500),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  brand.operatingHours!,
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
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                    size: 22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _brandImage() {
    final imageUrl = brand.bannerUrl ?? brand.logoUrl;
    if (imageUrl != null) {
      return Image.network(
        imageUrl,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _imageFallback(),
      );
    }
    return _imageFallback();
  }

  Widget _imageFallback() {
    return Container(
      height: 150,
      width: double.infinity,
      color: const Color(0xFFF5E6D8),
      child: const Center(
        child: Icon(Icons.restaurant, size: 52, color: AppColors.primary),
      ),
    );
  }

  String? _buildDistanceLabel() {
    final km = nearestOutlet?.distanceKm;
    if (km == null) return null;
    if (km < 1) return '${(km * 1000).round()} m';
    return '${km.toStringAsFixed(1)} km';
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ── Skeleton ──────────────────────────────────────────────────────────────────

class _BrandCardSkeleton extends StatelessWidget {
  const _BrandCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey.shade200),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 16,
                          width: 120,
                          color: Colors.grey.shade200),
                      const SizedBox(height: 8),
                      Container(
                          height: 12,
                          width: 180,
                          color: Colors.grey.shade200),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
