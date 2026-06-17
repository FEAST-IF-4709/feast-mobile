import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../../../features/order_tracking/domain/fulfillment_status.dart';
import '../../../shared/widgets/dashed_divider.dart';
import '../domain/order_summary.dart';
import '../providers/order_history_notifier.dart';

enum _HistoryFilter { all, active, completed, cancelled }

const _activeStatuses = {'RECEIVED', 'IN_PROGRESS', 'READY', 'SERVED'};

/// Riwayat pesanan lintas outlet milik customer yang sedang login.
/// Menggantikan lib/pages/history.dart.
class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  _HistoryFilter _filter = _HistoryFilter.all;

  List<OrderSummary> _applyFilter(List<OrderSummary> all) => switch (_filter) {
        _HistoryFilter.all => all,
        _HistoryFilter.active =>
          all.where((o) => _activeStatuses.contains(o.fulfillmentStatus)).toList(),
        _HistoryFilter.completed =>
          all.where((o) => o.fulfillmentStatus == 'COMPLETED').toList(),
        _HistoryFilter.cancelled =>
          all.where((o) => o.fulfillmentStatus == 'CANCELLED').toList(),
      };

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(orderHistoryNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async =>
              ref.invalidate(orderHistoryNotifierProvider),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Riwayat Pesanan',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Semua pesanan Anda dari berbagai outlet.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFilterChips(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              ordersAsync.when(
                loading: () => const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (err, _) => SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 60),
                      child: Column(
                        children: [
                          Icon(Icons.wifi_off_rounded,
                              size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'Gagal memuat riwayat pesanan.',
                            style: GoogleFonts.inter(color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () =>
                                ref.invalidate(orderHistoryNotifierProvider),
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                data: (orders) {
                  final filtered = _applyFilter(orders);
                  if (filtered.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 60),
                          child: Column(
                            children: [
                              Icon(Icons.receipt_long_outlined,
                                  size: 56, color: Colors.grey[300]),
                              const SizedBox(height: 16),
                              Text(
                                'Belum ada pesanan.',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final order = filtered[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _OrderCard(order: order),
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final chips = [
      (_HistoryFilter.all, 'Semua'),
      (_HistoryFilter.active, 'Aktif'),
      (_HistoryFilter.completed, 'Selesai'),
      (_HistoryFilter.cancelled, 'Dibatalkan'),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: chips.map((entry) {
          final (filter, label) = entry;
          final selected = _filter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _filter = filter),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? AppColors.primary
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : const Color(0xFF4A5568),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderSummary order;

  @override
  Widget build(BuildContext context) {
    final status = FulfillmentStatus.fromString(order.fulfillmentStatus);
    final label = status?.displayLabel ?? order.fulfillmentStatus;
    final (statusBg, statusFg) = _statusColors(order.fulfillmentStatus);

    final formattedDate = DateFormat('d MMM yyyy • HH:mm', 'id_ID')
        .format(order.placedAt.toLocal());
    final outletDisplay = order.outletName.isNotEmpty
        ? (order.brandName != null
            ? '${order.brandName} – ${order.outletName}'
            : order.outletName)
        : order.orderNumber;

    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.orderDetail.replaceFirst(':orderId', order.id),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.storefront_outlined,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              outletDisplay,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formattedDate,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: const Color(0xFF718096),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          label,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: statusFg,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const DashedDivider(),
                  const SizedBox(height: 14),
                  Text(
                    '${order.itemCount} item',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF9F5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF718096),
                        ),
                      ),
                      Text(
                        'Rp ${_formatAmount(order.grandTotal)}',
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.visibility_outlined,
                            size: 14, color: Color(0xFF1A1A1A)),
                        const SizedBox(width: 6),
                        Text(
                          'Lihat Detail',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
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
    );
  }

  (Color, Color) _statusColors(String status) => switch (status) {
        'COMPLETED' => (
          const Color(0xFFD1FAE5),
          const Color(0xFF065F46),
        ),
        'CANCELLED' => (
          const Color(0xFFF2F2F2),
          const Color(0xFF828282),
        ),
        _ => (
          const Color(0xFFFDE8D1),
          const Color(0xFF9E763E),
        ),
      };

  String _formatAmount(String raw) {
    final num = double.tryParse(raw) ?? 0;
    return NumberFormat('#,###', 'id_ID').format(num.toInt());
  }
}
