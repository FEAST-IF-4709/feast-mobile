import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../features/loyalty/providers/loyalty_notifier.dart';
import '../../../shared/widgets/dashed_divider.dart';
import '../domain/fulfillment_status.dart';
import '../domain/order_tracking_state.dart';
import '../providers/order_tracking_notifier.dart';

/// Realtime order tracking screen (PRD §5.9).
///
/// Driven by [OrderTrackingNotifier] — single WebSocket + polling. Shows:
/// - Amber reconnecting banner (CLAUDE.md §7.2)
/// - 5-step stepper with PRD §5.9 display labels (separate from enum values)
/// - CANCELLED banner outside the stepper (CLAUDE.md §7.6)
/// - Order item summary including per-item notes (FR-M06)
/// - Navigation to home + order history
class OrderTrackingScreen extends ConsumerWidget {
  final String orderId;
  final String? orderNumber;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
    this.orderNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingAsync = ref.watch(orderTrackingNotifierProvider(orderId));

    ref.listen<AsyncValue<OrderTrackingState>>(
      orderTrackingNotifierProvider(orderId),
      (prev, next) {
        final prevStatus = prev?.valueOrNull?.fulfillmentStatus;
        final nextState = next.valueOrNull;
        if (nextState == null) return;
        if (nextState.fulfillmentStatus != FulfillmentStatus.completed) return;
        if (prevStatus == FulfillmentStatus.completed) return;

        final points =
            (double.tryParse(nextState.grandTotal ?? '0') ?? 0) ~/ 10000;
        ref.invalidate(loyaltyAccountProvider);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '+$points poin diperoleh! • 1 poin per Rp 10.000',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              backgroundColor: const Color(0xFF16A34A),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: FeastColors.background,
      body: trackingAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: FeastColors.primary),
        ),
        error: (e, _) => _ErrorBody(
          message: e.toString(),
          onRetry: () =>
              ref.invalidate(orderTrackingNotifierProvider(orderId)),
        ),
        data: (state) => _TrackingBody(
          orderId: orderId,
          orderNumber: orderNumber ?? state.orderNumber,
          state: state,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Body
// ---------------------------------------------------------------------------

class _TrackingBody extends StatelessWidget {
  final String orderId;
  final String? orderNumber;
  final OrderTrackingState state;

  const _TrackingBody({
    required this.orderId,
    required this.orderNumber,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Status header ────────────────────────────────────────────────
          _StatusHeader(status: state.fulfillmentStatus),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Reconnecting banner (CLAUDE.md §7.2)
                if (state.isReconnecting) ...[
                  _ReconnectingBanner(),
                  const SizedBox(height: 16),
                ],

                // CANCELLED banner — outside stepper (CLAUDE.md §7.6)
                if (state.fulfillmentStatus ==
                    FulfillmentStatus.cancelled) ...[
                  _CancelledBanner(),
                  const SizedBox(height: 16),
                ],

                // 5-step stepper
                _FulfillmentStepper(status: state.fulfillmentStatus),
                const SizedBox(height: 16),

                // Selesai → tampilan detail ala riwayat pesanan
                // Belum selesai → kartu ringkas tracking
                if (state.fulfillmentStatus == FulfillmentStatus.served ||
                    state.fulfillmentStatus == FulfillmentStatus.completed)
                  _CompletedOrderCard(
                    orderNumber: orderNumber,
                    taxAmount: state.taxAmount,
                    grandTotal: state.grandTotal,
                    items: state.orderItems,
                    notes: state.orderNotes,
                    status: state.fulfillmentStatus,
                  )
                else
                  _OrderCard(
                    orderNumber: orderNumber,
                    taxAmount: state.taxAmount,
                    grandTotal: state.grandTotal,
                    items: state.orderItems,
                    notes: state.orderNotes,
                  ),
                const SizedBox(height: 24),

                // Primary: home
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/home'),
                    icon: const Icon(Icons.home_outlined),
                    label: Text(
                      'Kembali ke Beranda',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FeastColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(0, 52),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Secondary: history
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/order-history'),
                    icon: const Icon(Icons.receipt_long_outlined),
                    label: Text(
                      'Lihat Riwayat Pesanan',
                      style: GoogleFonts.inter(fontSize: 15),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: FeastColors.primary,
                      side: const BorderSide(color: FeastColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(0, 52),
                    ),
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

// ---------------------------------------------------------------------------
// Status header
// ---------------------------------------------------------------------------

class _StatusHeader extends StatelessWidget {
  final FulfillmentStatus status;

  const _StatusHeader({required this.status});

  @override
  Widget build(BuildContext context) {
    final isCancelled = status == FulfillmentStatus.cancelled;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 32),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: isCancelled ? Colors.red.shade400 : FeastColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCancelled
                  ? Icons.cancel_outlined
                  : Icons.restaurant_menu_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            status.headerTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: FeastColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Banners
// ---------------------------------------------------------------------------

class _ReconnectingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.amber.shade700,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Menghubungkan kembali…',
            style: GoogleFonts.inter(
              color: Colors.amber.shade800,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CancelledBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.cancel_outlined, color: Colors.red, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan Dibatalkan',
                  style: GoogleFonts.inter(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pesanan ini telah dibatalkan. Hubungi staf jika ada pertanyaan.',
                  style: GoogleFonts.inter(
                    color: Colors.red.shade700,
                    fontSize: 12,
                    height: 1.4,
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

// ---------------------------------------------------------------------------
// Fulfillment stepper
// ---------------------------------------------------------------------------

class _FulfillmentStepper extends StatelessWidget {
  final FulfillmentStatus status;

  const _FulfillmentStepper({required this.status});

  @override
  Widget build(BuildContext context) {
    // CANCELLED: keep stepper at last-known step (CLAUDE.md §7.6)
    final activeIndex =
        status == FulfillmentStatus.cancelled ? -1 : status.stepIndex;
    final isDone = status.isTerminal && status != FulfillmentStatus.cancelled;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          FulfillmentStatus.stepperStatuses.length,
          (i) {
            final stepStatus = FulfillmentStatus.stepperStatuses[i];
            final isCompleted = activeIndex >= 0 &&
                (i < activeIndex || (i == activeIndex && isDone));
            final isActive = i == activeIndex && !isDone;
            final isLast = i == FulfillmentStatus.stepperStatuses.length - 1;

            return _StepRow(
              label: stepStatus.displayLabel,
              subtitle: stepStatus.stepSubtitle,
              isCompleted: isCompleted,
              isActive: isActive,
              showConnector: !isLast,
            );
          },
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool showConnector;

  const _StepRow({
    required this.label,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
    required this.showConnector,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOn = isCompleted || isActive;

    final Color dotColor =
        isOn ? FeastColors.primary : Colors.grey.shade200;

    final Widget dotIcon;
    if (isCompleted) {
      dotIcon = const Icon(Icons.check_rounded, color: Colors.white, size: 16);
    } else if (isActive) {
      dotIcon = const Icon(Icons.access_time_rounded,
          color: Colors.white, size: 16);
    } else {
      dotIcon = const SizedBox.shrink();
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + connector column
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    border: isOn
                        ? null
                        : Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(child: dotIcon),
                ),
                if (showConnector)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? FeastColors.primary
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Label + subtitle
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 2,
                bottom: showConnector ? 22 : 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight:
                          isOn ? FontWeight.bold : FontWeight.normal,
                      color: isOn
                          ? FeastColors.textDark
                          : Colors.grey.shade400,
                    ),
                  ),
                  if (subtitle.isNotEmpty && (isCompleted || isActive)) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isActive
                            ? FeastColors.primary
                            : Colors.grey.shade500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order card
// ---------------------------------------------------------------------------

class _OrderCard extends StatelessWidget {
  final String? orderNumber;
  final String? taxAmount;
  final String? grandTotal;
  final List<TrackingOrderItem> items;
  final String? notes;

  const _OrderCard({
    required this.orderNumber,
    required this.taxAmount,
    required this.grandTotal,
    required this.items,
    this.notes,
  });

  String _fmt(String? raw) {
    if (raw == null) return '—';
    final val = double.tryParse(raw) ?? 0;
    return 'Rp ${NumberFormat('#,###', 'id_ID').format(val.toInt())}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ORDER ID row + PRE-PAID badge
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER ID',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade400,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        orderNumber ?? '—',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: FeastColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Text(
                    'PRE-PAID',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFF1DDD1)),

          // Items
          if (items.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                children: items
                    .map((item) => _ItemRow(item: item, fmt: _fmt))
                    .toList(),
              ),
            ),
          ],

          // Notes
          if (notes != null && notes!.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 20, color: Color(0xFFF1DDD1)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.notes_rounded,
                      size: 14, color: Colors.grey.shade400),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      notes!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 24, color: Color(0xFFF1DDD1)),
          ),

          // Total breakdown
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _TotalBreakdown(
              items: items,
              taxAmount: taxAmount,
              grandTotal: grandTotal,
              fmt: _fmt,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  final TrackingOrderItem item;
  final String Function(String?) fmt;

  const _ItemRow({required this.item, required this.fmt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: item.imageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => _imgPlaceholder(),
                    errorWidget: (_, _, _) => _imgPlaceholder(),
                  )
                : _imgPlaceholder(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: FeastColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.itemNotes != null && item.itemNotes!.isNotEmpty
                      ? 'x${item.quantity} • ${item.itemNotes}'
                      : 'x${item.quantity}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            fmt(item.lineTotal),
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: FeastColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imgPlaceholder() => Container(
        width: 40,
        height: 40,
        color: FeastColors.background,
        child: const Icon(Icons.fastfood_rounded,
            size: 18, color: FeastColors.primary),
      );
}

// ---------------------------------------------------------------------------
// Completed order card — mirrors order_detail_screen style (history view)
// ---------------------------------------------------------------------------

class _CompletedOrderCard extends StatelessWidget {
  final String? orderNumber;
  final String? taxAmount;
  final String? grandTotal;
  final List<TrackingOrderItem> items;
  final String? notes;
  final FulfillmentStatus status;

  const _CompletedOrderCard({
    required this.orderNumber,
    required this.taxAmount,
    required this.grandTotal,
    required this.items,
    required this.status,
    this.notes,
  });

  String _fmt(String? raw) {
    if (raw == null) return '—';
    final val = double.tryParse(raw) ?? 0;
    return 'Rp ${NumberFormat('#,###', 'id_ID').format(val.toInt())}';
  }

  @override
  Widget build(BuildContext context) {
    final (badgeBg, badgeFg) = status == FulfillmentStatus.completed
        ? (const Color(0xFFD1FAE5), const Color(0xFF065F46))
        : (const Color(0xFFFDE8D1), const Color(0xFF9E763E));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Header card ──────────────────────────────────────────────────
        _HistoryCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderNumber ?? '—',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status.displayLabel,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: badgeFg,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ── Items card ───────────────────────────────────────────────────
        _HistoryCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ITEM PESANAN',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              ...items.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (i > 0) ...[
                      const SizedBox(height: 10),
                      const DashedDivider(),
                      const SizedBox(height: 10),
                    ],
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1E8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${item.quantity}x',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: FeastColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                              if (item.itemNotes != null &&
                                  item.itemNotes!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    'Catatan: ${item.itemNotes}',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          'Rp ${_fmt(item.lineTotal)}',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              if (notes != null && notes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                const DashedDivider(),
                const SizedBox(height: 12),
                Text(
                  'Catatan Pesanan',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notes!,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ── Total card ───────────────────────────────────────────────────
        _HistoryCard(
          child: _TotalBreakdown(
            items: items,
            taxAmount: taxAmount,
            grandTotal: grandTotal,
            fmt: _fmt,
          ),
        ),
      ],
    );
  }
}

class _TotalBreakdown extends StatelessWidget {
  final List<TrackingOrderItem> items;
  final String? taxAmount;
  final String? grandTotal;
  final String Function(String?) fmt;

  const _TotalBreakdown({
    required this.items,
    required this.taxAmount,
    required this.grandTotal,
    required this.fmt,
  });

  @override
  Widget build(BuildContext context) {
    final subtotalVal = items.fold(
      0.0,
      (sum, item) => sum + (double.tryParse(item.lineTotal) ?? 0),
    );
    final taxVal = double.tryParse(taxAmount ?? '0') ?? 0;

    return Column(
      children: [
        _PriceRow(
          label: 'Subtotal',
          value: fmt(subtotalVal.toStringAsFixed(2)),
        ),
        if (taxVal > 0) ...[
          const SizedBox(height: 8),
          _PriceRow(label: 'Pajak', value: fmt(taxAmount)),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
        _PriceRow(
          label: 'Total Pembayaran',
          value: fmt(grandTotal),
          isBold: true,
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? FeastColors.textDark : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isBold ? 15 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? FeastColors.primary : FeastColors.textDark,
          ),
        ),
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      );
}

// ---------------------------------------------------------------------------
// Error body
// ---------------------------------------------------------------------------

class _ErrorBody extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBody({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
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
}
