import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../brands/providers/brand_notifier.dart';
import '../../cart/providers/cart_notifier.dart';
import '../../qr_session/providers/qr_session_notifier.dart';
import '../domain/menu_item.dart';
import '../providers/menu_notifier.dart';

/// Outlet-scoped menu screen — the primary screen after QR resolution.
///
/// Shows a brand banner + logo header, category chips, a search bar, and a
/// 2-column item grid. When no QR session is active, shows an empty state
/// prompting the user to scan.
class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  String _searchQuery = '';
  String? _selectedCategoryId;

  String _formatPrice(String priceStr) {
    final price = double.tryParse(priceStr) ?? 0;
    return NumberFormat('#,###', 'id_ID').format(price.toInt());
  }

  List<MenuItem> _filteredItems(List<MenuCategory> categories) {
    final allItems = _selectedCategoryId == null
        ? categories.expand((c) => c.items).toList()
        : categories
            .where((c) => c.categoryId == _selectedCategoryId)
            .expand((c) => c.items)
            .toList();

    if (_searchQuery.isEmpty) return allItems;
    final q = _searchQuery.toLowerCase();
    return allItems
        .where((item) => item.name.toLowerCase().contains(q))
        .toList();
  }

  void _onNavTap(int index) {
    if (index == 1) return; // already here (Store tab active)
    if (index == 0) context.go(AppRoutes.home);
    if (index == 2) context.push(AppRoutes.orderHistory);
    if (index == 3) context.push(AppRoutes.profile);
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(qrSessionNotifierProvider);
    final menuAsync = ref.watch(menuNotifierProvider);
    final cart = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final totalItems = cartNotifier.totalItemCount;
    final totalAmount = cartNotifier.totalAmount;
    final brandsAsync = ref.watch(brandNotifierProvider);

    return sessionAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text(e.toString())),
      ),
      data: (session) {
        if (session == null) return _buildNoSession(context);

        final brand = brandsAsync.valueOrNull
            ?.where((b) => b.id == session.brandId)
            .firstOrNull;

        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: _buildQrFab(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _buildBottomNav(),
          body: Stack(
            children: [
              menuAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => _buildError(e.toString()),
                data: (categories) {
                  if (categories == null || categories.isEmpty) {
                    return _buildEmptyMenu();
                  }
                  return _buildMenuContent(
                      context, session, categories, brand,
                      hasCart: cart.isNotEmpty);
                },
              ),
              // Cart strip overlay di atas body, tepat di atas nav bar
              if (cart.isNotEmpty)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildCartStrip(
                      context, totalItems, totalAmount),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNoSession(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFFDF2E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  size: 40,
                  color: FeastColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Scan QR untuk memesan',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Scan kode QR di meja Anda untuk melihat menu dan mulai memesan.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(menuNotifierProvider),
              style: ElevatedButton.styleFrom(
                backgroundColor: FeastColors.primary,
              ),
              child: Text(
                'Coba Lagi',
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyMenu() {
    return Center(
      child: Text(
        'Menu belum tersedia',
        style: GoogleFonts.inter(color: Colors.grey),
      ),
    );
  }

  Widget _buildMenuContent(
    BuildContext context,
    dynamic session,
    List<MenuCategory> categories,
    dynamic brand, {
    bool hasCart = false,
  }) {
    final filtered = _filteredItems(categories);

    return RefreshIndicator(
      color: FeastColors.primary,
      onRefresh: () async => ref.invalidate(menuNotifierProvider),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Collapsible brand banner
          _buildSliverAppBar(context, session, brand),

          // Brand info card (logo + name + outlet + table)
          SliverToBoxAdapter(
            child: _buildBrandInfoCard(context, session, brand),
          ),

          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _buildSearchBar(),
            ),
          ),

          // Category chips
          SliverToBoxAdapter(
            child: _buildCategoryChips(categories),
          ),

          // Item grid
          if (filtered.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'Tidak ada menu yang cocok',
                  style: GoogleFonts.inter(color: Colors.grey),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildItemCard(context, filtered[index]),
                  childCount: filtered.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
              ),
            ),

          // Extra padding when cart strip is visible
          SliverToBoxAdapter(
            child: SizedBox(height: hasCart ? 148 : 100),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(
    BuildContext context,
    dynamic session,
    dynamic brand,
  ) {
    final bannerUrl = brand?.bannerUrl ?? brand?.logoUrl;

    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: const Color(0xFFDD7A00),
      elevation: 0,
      leading: GestureDetector(
        onTap: () =>
            context.canPop() ? context.pop() : context.go(AppRoutes.home),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.table_bar_outlined,
                  size: 14, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                session.tableLabel as String,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
      title: Text(
        session.outletName as String,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: bannerUrl != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: bannerUrl as String,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => _bannerFallback(),
                    errorWidget: (_, _, _) => _bannerFallback(),
                  ),
                  // Gradient overlay for legibility
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : _bannerFallback(),
      ),
    );
  }

  Widget _bannerFallback() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFDD7A00), Color(0xFFE8931A)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant_menu,
          size: 56,
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
    );
  }

  Widget _buildBrandInfoCard(
    BuildContext context,
    dynamic session,
    dynamic brand,
  ) {
    final logoUrl = brand?.logoUrl as String?;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Brand logo circle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color(0xFFF1DDD1), width: 2),
              color: const Color(0xFFF5E6D8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: logoUrl != null
                  ? CachedNetworkImage(
                      imageUrl: logoUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => const Center(
                        child: Icon(Icons.restaurant,
                            size: 30, color: FeastColors.primary),
                      ),
                      errorWidget: (_, _, _) => const Center(
                        child: Icon(Icons.restaurant,
                            size: 30, color: FeastColors.primary),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.restaurant,
                          size: 30, color: FeastColors.primary),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          // Brand name + outlet name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.brandName as String,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.storefront_outlined,
                        size: 13, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        session.outletName as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (brand?.cuisineType != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: FeastColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      (brand!.cuisineType as String).toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: FeastColors.primary,
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        style: GoogleFonts.inter(fontSize: 14),
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'Cari menu…',
          hintStyle:
              GoogleFonts.inter(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon:
              const Icon(Icons.search, color: Colors.black54, size: 20),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () => setState(() => _searchQuery = ''),
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        ),
      ),
    );
  }

  Widget _buildCategoryChips(List<MenuCategory> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          _chip('Semua', null),
          ...categories.map((c) => _chip(c.categoryName, c.categoryId)),
        ],
      ),
    );
  }

  Widget _chip(String label, String? categoryId) {
    final isActive = _selectedCategoryId == categoryId;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategoryId = categoryId),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? FeastColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isActive ? FeastColors.primary : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, MenuItem item) {
    return GestureDetector(
      onTap: () => context.push(
        '/item/${item.outletProductId}',
        extra: item,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    item.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: item.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (_, _) => Container(
                              color: const Color(0xFFF5E6D8),
                            ),
                            errorWidget: (_, _, _) => Container(
                              color: const Color(0xFFF5E6D8),
                              child: const Icon(Icons.restaurant,
                                  color: Colors.white54),
                            ),
                          )
                        : Container(
                            color: const Color(0xFFF5E6D8),
                            child: const Icon(Icons.restaurant,
                                color: Colors.white54),
                          ),
                    if (!item.stockAvailable)
                      Container(
                        color: Colors.black.withValues(alpha: 0.45),
                        child: Center(
                          child: Text(
                            'Habis',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${_formatPrice(item.effectivePrice)}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: FeastColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: item.stockAvailable
                          ? () => context.push(
                                '/item/${item.outletProductId}',
                                extra: item,
                              )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FeastColors.primary,
                        disabledBackgroundColor: Colors.grey.shade200,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 36),
                      ),
                      child: Text(
                        item.stockAvailable ? 'Tambah' : 'Habis',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: item.stockAvailable
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── QR FAB (identik dengan HomeScreen) ────────────────────────────────────

  Widget _buildQrFab(BuildContext context) {
    return GestureDetector(
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
    );
  }

  // ── Bottom nav + cart strip (identik dengan HomeScreen) ────────────────────

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
            _MenuNavItem(
              icon: Icons.home_outlined,
              index: 0,
              selected: 1,
              onTap: _onNavTap,
            ),
            _MenuNavItem(
              icon: Icons.store_outlined,
              index: 1,
              selected: 1,
              onTap: _onNavTap,
            ),
            const SizedBox(width: 48),
            _MenuNavItem(
              icon: Icons.receipt_long_outlined,
              index: 2,
              selected: 1,
              onTap: _onNavTap,
            ),
            _MenuNavItem(
              icon: Icons.person_outline,
              index: 3,
              selected: 1,
              onTap: _onNavTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartStrip(
      BuildContext context, int totalItems, double totalAmount) {
    final formatted =
        NumberFormat('#,###', 'id_ID').format(totalAmount.toInt());
    return GestureDetector(
      onTap: () => context.push(AppRoutes.cart),
      child: Container(
        width: double.infinity,
        color: FeastColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$totalItems',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Lihat Keranjang',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              'Rp $formatted',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Nav item (identik dengan HomeScreen) ──────────────────────────────────────

class _MenuNavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selected;
  final ValueChanged<int> onTap;

  const _MenuNavItem({
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
          color: isSelected ? FeastColors.primary : Colors.transparent,
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

// ignore: unused_element
class _NavItemWithBadge extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int selectedIndex;
  final int badgeCount;
  final void Function(int) onTap;

  const _NavItemWithBadge({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  size: 24,
                  color:
                      isActive ? FeastColors.primary : Colors.grey.shade400,
                ),
                if (badgeCount > 0)
                  Positioned(
                    top: -5,
                    right: -8,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: FeastColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          badgeCount > 9 ? '9+' : '$badgeCount',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight:
                    isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? FeastColors.primary : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
