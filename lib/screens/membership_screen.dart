import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../core/app_colors.dart';
import '../features/loyalty/domain/loyalty_account.dart';
import '../features/loyalty/providers/loyalty_notifier.dart';

class MembershipScreen extends ConsumerWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loyaltyAsync = ref.watch(loyaltyAccountProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Membership',
          style: GoogleFonts.inter(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: loyaltyAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text('Gagal memuat data loyalty.',
                  style: GoogleFonts.inter(color: Colors.grey[600])),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => ref.invalidate(loyaltyAccountProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
        data: (loyalty) => _MembershipBody(loyalty: loyalty),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tier config — mirrors backend apps/customers/loyalty.py thresholds.
// Update if backend adjusts tier rules.
// ---------------------------------------------------------------------------

const _tiers = ['BRONZE', 'SILVER', 'GOLD'];

const _tierThreshold = {'SILVER': 100, 'GOLD': 200};

/// Points in window needed to reach [tier].
int _thresholdFor(String tier) => _tierThreshold[tier] ?? 0;

/// Display name for a tier key.
String _tierName(String tier) => switch (tier) {
      'GOLD' => 'Gold',
      'SILVER' => 'Silver',
      _ => 'Bronze',
    };

/// Next tier above [current], or null if already at top.
String? _nextTier(String current) => switch (current) {
      'BRONZE' => 'SILVER',
      'SILVER' => 'GOLD',
      _ => null,
    };

/// Tier benefit list. Earn-rate is aspirational — actual rate is
/// 1 pt per Rp 10.000 for all tiers (backend award_points_for_order).
const _tierBenefits = {
  'BRONZE': [
    'Earn 1 pt per Rp 10.000 dipesan',
    'Birthday treat',
    'App Ordering',
  ],
  'SILVER': [
    'Earn 1,5 pt per Rp 10.000 dipesan',
    'Free Delivery via app',
    'Monthly Silver Voucher',
    'Early access to new items',
  ],
  'GOLD': [
    'Earn 2 pt per Rp 10.000 dipesan',
    'Free Delivery via app',
    'Priority Support',
    'Exclusive Events Access',
  ],
};

// ---------------------------------------------------------------------------

class _MembershipBody extends StatelessWidget {
  const _MembershipBody({required this.loyalty});

  final LoyaltyAccount loyalty;

  @override
  Widget build(BuildContext context) {
    final next = _nextTier(loyalty.tier);
    final nextThreshold = next != null ? _thresholdFor(next) : _thresholdFor('GOLD');
    final progress = next != null
        ? min(1.0, loyalty.tierPointsInWindow / nextThreshold)
        : 1.0;
    final remaining = next != null
        ? max(0, nextThreshold - loyalty.tierPointsInWindow)
        : 0;

    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Header ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('FEAST Rewards',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900, fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  'Unlock exclusive dining perks and experiences as you level up.',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // ── Tier cards ────────────────────────────────────────────────────
          SizedBox(
            height: 340,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _tiers.map((t) {
                  final isCurrent = t == loyalty.tier;
                  final benefits = _tierBenefits[t] ?? [];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isCurrent
                            ? AppColors.primary
                            : Colors.grey.withValues(alpha: 0.2),
                        width: 2,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'TIER ANDA',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _tierName(t),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 26,
                                    color: isCurrent
                                        ? AppColors.primary
                                        : Colors.black,
                                  ),
                                ),
                                Text(
                                  isCurrent
                                      ? '${loyalty.pointsBalance} pts'
                                      : '—',
                                  style: GoogleFonts.inter(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.stars,
                                  color: AppColors.primary, size: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ...benefits.map((benefit) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      color: isCurrent
                                          ? AppColors.primary
                                          : Colors.grey[400],
                                      size: 20),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(benefit,
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // ── Progress card ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: next != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Menuju ${_tierName(next)}',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '${loyalty.tierPointsInWindow} ',
                                    style: GoogleFonts.inter(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                TextSpan(
                                    text: '/ $nextThreshold pts',
                                    style: GoogleFonts.inter(
                                        color: Colors.grey, fontSize: 14)),
                              ]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          // Client-side threshold, pending backend tier-event integration (PRD §5.12)
                          'Kumpulkan $remaining pts lagi bulan ini untuk naik ke ${_tierName(next)}',
                          style: GoogleFonts.inter(
                              color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(Icons.emoji_events,
                            color: AppColors.primary, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Anda sudah di tier tertinggi — Gold! 🌟',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // ── Transaction history ───────────────────────────────────────────
          if (loyalty.transactions.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Riwayat Poin',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...loyalty.transactions.map((txn) => _TxnTile(txn: txn)),
          ] else ...[
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Belum ada riwayat poin.',
                  style: GoogleFonts.inter(color: Colors.grey[500]),
                ),
              ),
            ),
          ],

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _TxnTile extends StatelessWidget {
  const _TxnTile({required this.txn});
  final LoyaltyTransaction txn;

  @override
  Widget build(BuildContext context) {
    final isEarn = txn.txnType == 'EARN';
    final color = isEarn ? const Color(0xFF16A34A) : const Color(0xFFE07B00);
    final sign = isEarn ? '+' : '−';
    final formattedDate = DateFormat('d MMM yyyy, HH:mm', 'id_ID')
        .format(txn.createdAt.toLocal());

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isEarn ? Icons.arrow_downward : Icons.arrow_upward,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.note ?? (isEarn ? 'Poin diperoleh' : 'Penukaran poin'),
                  style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(formattedDate,
                    style:
                        GoogleFonts.inter(fontSize: 11, color: Colors.grey[500])),
              ],
            ),
          ),
          Text(
            '$sign${txn.points} pts',
            style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
