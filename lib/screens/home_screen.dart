import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_colors.dart';
import '../core/router/app_routes.dart';
import '../features/auth/providers/auth_notifier.dart';
import '../features/brands/domain/brand.dart';
import '../features/brands/presentation/brands_screen.dart';
import '../features/brands/providers/brand_notifier.dart';
import '../features/brands/providers/location_provider.dart';
import '../features/loyalty/domain/loyalty_account.dart';
import '../features/loyalty/providers/loyalty_notifier.dart';
import '../features/menu/domain/menu_item.dart';
import '../features/menu/providers/menu_notifier.dart';
import '../features/order_history/presentation/order_history_screen.dart';
import '../features/profile/providers/profile_notifier.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/qr_session/providers/qr_session_notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeContent(onSeeAllBrands: () => setState(() => _selectedIndex = 1)),
      const BrandsScreen(),
      const OrderHistoryScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: pages[_selectedIndex]),
      floatingActionButton: GestureDetector(
        onTap: () => context.push(AppRoutes.qrScan),
        child: Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.grey,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 20,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              index: 0,
              selected: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
            ),
            _NavItem(
              icon: Icons.store_outlined,
              index: 1,
              selected: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
            ),
            const SizedBox(width: 48),
            _NavItem(
              icon: Icons.receipt_long_outlined,
              index: 2,
              selected: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
            ),
            _NavItem(
              icon: Icons.person_outline,
              index: 3,
              selected: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Home tab content ─────────────────────────────────────────────────────────

class _HomeContent extends ConsumerWidget {
  final VoidCallback onSeeAllBrands;

  const _HomeContent({required this.onSeeAllBrands});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(qrSessionNotifierProvider);
    final authAsync = ref.watch(authNotifierProvider);
    final profileAsync = ref.watch(profileNotifierProvider);
    final loyalty = ref.watch(loyaltyAccountProvider).valueOrNull;
    final menuAsync = ref.watch(menuNotifierProvider);

    final fullName = authAsync.valueOrNull?.whenOrNull(
          authenticated: (_, customer) => customer.fullName,
        ) ??
        '';

    final String? photoUrl = profileAsync.maybeWhen(
      data: (p) => p.localPhotoPath ?? p.profilePhotoUrl,
      orElse: () => authAsync.valueOrNull?.whenOrNull(
        authenticated: (_, c) => c.profilePhotoUrl,
      ),
    );

    final tierLabel = _tierLabel(loyalty);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header
          _buildHeader(context, fullName, photoUrl, tierLabel),

          // 2. Hero Banner
          _HeroBanner(menuAsync: menuAsync),

          // 3. Stats Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildStatsCards(context, loyalty),
          ),
          const SizedBox(height: 16),

          // 4. Scan & Order / Active Session
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: sessionAsync.maybeWhen(
              data: (session) => session != null
                  ? _ActiveSessionCard(
                      outletName: session.outletName,
                      tableLabel: session.tableLabel,
                    )
                  : const _ScanQrCtaCard(),
              orElse: () => const _ScanQrCtaCard(),
            ),
          ),
          const SizedBox(height: 24),

          // 5. Featured Brands
          _FeaturedBrandsSection(onSeeAll: onSeeAllBrands),
          const SizedBox(height: 24),

          // 6. Hot Deals
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hot Deals 🔥',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.menu),
                  child: Text(
                    'See All',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildHotDeals(menuAsync),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  String _tierLabel(LoyaltyAccount? loyalty) {
    if (loyalty == null) return '';
    return switch (loyalty.tier) {
      'GOLD' => 'Gold Member',
      'SILVER' => 'Silver Member',
      _ => 'Bronze Member',
    };
  }

  Widget _buildHeader(
    BuildContext context,
    String fullName,
    String? photoUrl,
    String tierLabel,
  ) {
    final displayName = fullName.isNotEmpty
        ? '${fullName[0].toUpperCase()}${fullName.substring(1)}'
        : 'Guest';
    final initial =
        fullName.isNotEmpty ? fullName[0].toUpperCase() : 'G';

    return GestureDetector(
      onTap: () => context.push(AppRoutes.profile),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Row(
          children: [
            _ProfileAvatar(photoUrl: photoUrl, initial: initial),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, $displayName',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (tierLabel.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9A5300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tierLabel.toUpperCase(),
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
            const Spacer(),
            Stack(
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context, LoyaltyAccount? loyalty) {
    final tierLabel = switch (loyalty?.tier) {
      'GOLD' => 'Gold Tier',
      'SILVER' => 'Silver Tier',
      _ => loyalty != null ? 'Bronze Tier' : '— Tier',
    };
    final pointsText = loyalty != null ? '${loyalty.pointsBalance}' : '--';
    final rewardsCount = loyalty != null
        ? loyalty.transactions.where((t) => t.txnType == 'EARN').length
        : 0;
    final rewardsText = loyalty != null ? '$rewardsCount' : '--';

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.push(AppRoutes.membership),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1DDD1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.workspace_premium_outlined,
                        color: Color(0xFF9A5300),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          tierLabel,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF9A5300),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    pointsText,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE07B00),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Points Available',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => context.push(AppRoutes.membership),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1DDD1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.card_giftcard_outlined,
                        color: Color(0xFFE07B00),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'REWARDS',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2B1C14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    rewardsText,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2B1C14),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHotDeals(AsyncValue<List<MenuCategory>?> menuAsync) {
    return menuAsync.when(
      loading: () => SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 3,
          itemBuilder: (_, _) => const Padding(
            padding: EdgeInsets.only(right: 14),
            child: _HotDealSkeleton(),
          ),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (categories) {
        if (categories == null) {
          return _buildDealsEmptyCard('Scan QR meja untuk melihat promo aktif di outlet kamu.');
        }

        final deals = categories
            .expand((c) => c.items)
            .where((i) => i.activePromotion != null && i.stockAvailable)
            .toList();

        if (deals.isEmpty) {
          return _buildDealsEmptyCard('Belum ada promo aktif saat ini.');
        }

        return SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: deals.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(right: 14),
              child: _HotDealCard(item: deals[i]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDealsEmptyCard(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF1DDD1)),
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ),
    );
  }

}

// ── Hero Banner ───────────────────────────────────────────────────────────────

class _HeroBanner extends ConsumerWidget {
  final AsyncValue<List<MenuCategory>?> menuAsync;

  const _HeroBanner({required this.menuAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoItem = menuAsync.valueOrNull
        ?.expand((c) => c.items)
        .where((i) =>
            i.activePromotion != null &&
            i.stockAvailable &&
            i.imageUrl != null)
        .firstOrNull;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (promoItem?.imageUrl != null)
                Image.network(
                  promoItem!.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _fallbackBackground(),
                )
              else
                _fallbackBackground(),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.45),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_offer_rounded,
                          size: 13, color: AppColors.primary),
                      const SizedBox(width: 5),
                      Text(
                        'SPECIAL OFFER',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (promoItem != null)
                Positioned(
                  bottom: 14,
                  left: 14,
                  right: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        promoItem.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Rp ${_formatRupiah(promoItem.effectivePrice)}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fallbackBackground() {
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
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
    );
  }
}

// ── Featured Brands ───────────────────────────────────────────────────────────

class _FeaturedBrandsSection extends ConsumerWidget {
  final VoidCallback onSeeAll;

  const _FeaturedBrandsSection({required this.onSeeAll});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandNotifierProvider);
    final position = ref.watch(currentLocationProvider).valueOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Brands',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'See All',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        brandsAsync.when(
          loading: () => SizedBox(
            height: 88,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 5,
              itemBuilder: (_, _) => const Padding(
                padding: EdgeInsets.only(right: 18),
                child: _BrandCircleSkeleton(),
              ),
            ),
          ),
          error: (_, _) => const SizedBox.shrink(),
          data: (brands) {
            final sorted = [...brands];
            if (position != null) {
              sorted.sort((a, b) {
                final da = (a.latitude != null && a.longitude != null)
                    ? distanceMetres(position.latitude, position.longitude, a.latitude!, a.longitude!)
                    : double.infinity;
                final db = (b.latitude != null && b.longitude != null)
                    ? distanceMetres(position.latitude, position.longitude, b.latitude!, b.longitude!)
                    : double.infinity;
                return da.compareTo(db);
              });
            } else {
              sorted.sort((a, b) => a.name.compareTo(b.name));
            }
            return SizedBox(
              height: 88,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: sorted.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: _BrandCircle(brand: sorted[i]),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _BrandCircle extends StatelessWidget {
  final Brand brand;

  const _BrandCircle({required this.brand});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.brandDetail.replaceFirst(':brandId', brand.id),
        extra: brand,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF5E6D8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: brand.logoUrl != null
                ? Image.network(
                    brand.logoUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Center(
                      child: Icon(Icons.restaurant,
                          size: 26, color: AppColors.primary),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.restaurant,
                        size: 26, color: AppColors.primary),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 62,
          child: Text(
            brand.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
      ),
    );
  }
}

class _BrandCircleSkeleton extends StatelessWidget {
  const _BrandCircleSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 48,
          height: 10,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}

// ── Profile avatar ────────────────────────────────────────────────────────────

class _ProfileAvatar extends StatelessWidget {
  final String? photoUrl;
  final String initial;

  const _ProfileAvatar({required this.photoUrl, required this.initial});

  @override
  Widget build(BuildContext context) {
    final isLocalFile = photoUrl != null && !photoUrl!.startsWith('http');
    final hasRemote = photoUrl != null && photoUrl!.startsWith('http');

    ImageProvider? image;
    if (isLocalFile) {
      image = FileImage(File(photoUrl!));
    } else if (hasRemote) {
      image = NetworkImage(photoUrl!);
    }

    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.15),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        image: image != null
            ? DecorationImage(image: image, fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? Center(
              child: Text(
                initial,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            )
          : null,
    );
  }
}

// ── Hot deal card ─────────────────────────────────────────────────────────────

class _HotDealCard extends StatelessWidget {
  final MenuItem item;

  const _HotDealCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final promo = item.activePromotion!;
    final originalPrice = double.tryParse(item.price) ?? 0;
    final effectivePrice = double.tryParse(item.effectivePrice) ?? 0;
    final discountLabel = promo.discountType == 'PERCENT'
        ? '${promo.discountValue.replaceAll(RegExp(r'\.?0+$'), '')}% OFF'
        : '-Rp ${_formatRupiah(promo.discountValue)}';

    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: item.imageUrl != null
                    ? Image.network(
                        item.imageUrl!,
                        height: 120,
                        width: 160,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _imagePlaceholder(),
                      )
                    : _imagePlaceholder(),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    discountLabel,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rp ${_formatRupiah(item.effectivePrice)}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.primary,
                          ),
                        ),
                        if (effectivePrice < originalPrice)
                          Text(
                            'Rp ${_formatRupiah(item.price)}',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.grey.shade400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2B1C14),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add,
                          color: Colors.white, size: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      height: 120,
      width: 160,
      color: const Color(0xFFF5E6D8),
      child: const Icon(Icons.restaurant_menu,
          color: Color(0xFFE07B00), size: 36),
    );
  }
}

// ── Skeleton placeholder ──────────────────────────────────────────────────────

class _HotDealSkeleton extends StatelessWidget {
  const _HotDealSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(height: 120, width: 160, color: Colors.grey.shade200),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 12, width: 110, color: Colors.grey.shade200),
                const SizedBox(height: 6),
                Container(height: 10, width: 80, color: Colors.grey.shade200),
                const SizedBox(height: 8),
                Container(height: 12, width: 60, color: Colors.grey.shade200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Active session card ───────────────────────────────────────────────────────

class _ActiveSessionCard extends StatelessWidget {
  final String outletName;
  final String tableLabel;

  const _ActiveSessionCard({
    required this.outletName,
    required this.tableLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.menu),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDD7A00), Color(0xFFE8931A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.table_bar_outlined,
                  color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    outletName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Meja $tableLabel  •  Sesi aktif',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Lihat Menu',
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Scan QR CTA ───────────────────────────────────────────────────────────────

class _ScanQrCtaCard extends StatelessWidget {
  const _ScanQrCtaCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.qrScan),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF2E9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1DDD1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scan & Order',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to order directly from your table.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF2B1C14),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bottom nav item ───────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selected;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

String _formatRupiah(String rawPrice) {
  final amount = (double.tryParse(rawPrice) ?? 0).toInt();
  final s = amount.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return buf.toString();
}
