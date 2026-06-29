import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/api/api_exception.dart';
import '../../../shared/utils/url_utils.dart';
import '../domain/loyalty_account.dart';
import '../domain/voucher_template.dart';
import '../providers/loyalty_notifier.dart';
import '../providers/voucher_provider.dart';
import '../data/voucher_repository.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Rewards',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2B1C14),
          ),
        ),
        centerTitle: true,
      ),
      body: const _RewardsCatalog(),
    );
  }
}

// ── Body — own ConsumerWidget so Flutter tracks state transitions cleanly ──────

class _RewardsCatalog extends ConsumerWidget {
  const _RewardsCatalog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loyaltyAsync = ref.watch(loyaltyAccountProvider);
    final catalogAsync = ref.watch(voucherCatalogProvider);

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              ref.invalidate(voucherCatalogProvider);
              ref.invalidate(loyaltyAccountProvider);
            },
            child: _buildList(context, ref, loyaltyAsync, catalogAsync),
          ),
        ),
      ],
    );
  }

  Widget _buildList(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<LoyaltyAccount> loyaltyAsync,
    AsyncValue<List<VoucherTemplate>> catalogAsync,
  ) {
    final loyalty = loyaltyAsync.valueOrNull;
    final templates = catalogAsync.valueOrNull;
    final isLoading = catalogAsync.isLoading;
    final hasError = catalogAsync.hasError && templates == null;
    final userPoints = loyalty?.pointsBalance ?? 0;

    // ── Loading ───────────────────────────────────────────────────────────────
    if (isLoading && templates == null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          _PointsHeaderWidget(loyalty: loyalty, isLoading: loyaltyAsync.isLoading),
          const SizedBox(height: 40),
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Memuat katalog voucher...',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ],
      );
    }

    // ── Error ─────────────────────────────────────────────────────────────────
    if (hasError) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          _PointsHeaderWidget(loyalty: loyalty, isLoading: loyaltyAsync.isLoading),
          const SizedBox(height: 40),
          const Center(
            child: Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Gagal memuat voucher.\nTarik ke bawah untuk coba lagi.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),
        ],
      );
    }

    // ── Empty ─────────────────────────────────────────────────────────────────
    final list = templates ?? [];
    if (list.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          _PointsHeaderWidget(loyalty: loyalty, isLoading: loyaltyAsync.isLoading),
          const SizedBox(height: 40),
          const _EmptyState(),
        ],
      );
    }

    // ── Data ──────────────────────────────────────────────────────────────────
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _PointsHeaderWidget(loyalty: loyalty, isLoading: loyaltyAsync.isLoading),
        const SizedBox(height: 12),
        for (final t in list)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: _VoucherCard(
              template: t,
              userPoints: userPoints,
              onRedeem: () => _handleRedeem(context, ref, t),
            ),
          ),
        const SizedBox(height: 32),
      ],
    );
  }

  Future<void> _handleRedeem(
    BuildContext context,
    WidgetRef ref,
    VoucherTemplate template,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Tukar Poin',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Tukar ${template.pointsCost} poin untuk mendapatkan voucher '
          '"${template.title}"?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Tukar',
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await ref.read(voucherRepositoryProvider).redeem(template.id);
      ref.invalidate(loyaltyAccountProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Voucher "${template.title}" berhasil ditukar!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        final msg = e is ApiException ? e.message : 'Penukaran gagal.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red),
        );
      }
    }
  }
}

// ── Points header ─────────────────────────────────────────────────────────────

class _PointsHeaderWidget extends StatelessWidget {
  const _PointsHeaderWidget({required this.loyalty, required this.isLoading});

  final LoyaltyAccount? loyalty;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (loyalty == null && isLoading) return const _PointsHeaderSkeleton();
    if (loyalty == null) return const SizedBox(height: 8);
    final tier = loyalty!.tier.isEmpty ? 'BRONZE' : loyalty!.tier;
    return _PointsHeader(points: loyalty!.pointsBalance, tier: tier);
  }
}

class _PointsHeader extends StatelessWidget {
  const _PointsHeader({required this.points, required this.tier});

  final int points;
  final String tier;

  @override
  Widget build(BuildContext context) {
    final label = tier.isNotEmpty
        ? '${tier[0]}${tier.substring(1).toLowerCase()} Member'
        : 'Bronze Member';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDD7A00), Color(0xFFFF9F40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$points Poin',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.card_giftcard_outlined,
              color: Colors.white54, size: 40),
        ],
      ),
    );
  }
}

class _PointsHeaderSkeleton extends StatelessWidget {
  const _PointsHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

// ── Voucher card (no image — for testing) ────────────────────────────────────


// ── Voucher card ─────────────────────────────────────────────────────────────

class _VoucherCard extends StatelessWidget {
  const _VoucherCard({
    super.key,
    required this.template,
    required this.userPoints,
    required this.onRedeem,
  });

  final VoucherTemplate template;
  final int userPoints;
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    final canRedeem = userPoints >= template.pointsCost;
    final imageUrl = fixMediaUrl(template.imageUrl);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF1DDD1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child: SizedBox(
              width: 90,
              height: 90,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const _ImagePlaceholder(),
                    )
                  : const _ImagePlaceholder(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (template.brandName != null)
                    Text(
                      template.brandName!,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    template.title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2B1C14),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.primary, size: 14),
                      const SizedBox(width: 3),
                      Text(
                        '${template.pointsCost} poin',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: canRedeem ? onRedeem : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: canRedeem ? AppColors.primary : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Tukar',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: canRedeem ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF0E0),
      child: const Center(
        child: Icon(Icons.card_giftcard_outlined,
            color: AppColors.primary, size: 32),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.card_giftcard_outlined,
                size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Belum ada reward tersedia',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Brand belum menambahkan reward.\nCek lagi nanti!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
