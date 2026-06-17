import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/order_tracking/domain/fulfillment_status.dart';
import '../../../shared/widgets/dashed_divider.dart';
import '../domain/order_detail.dart';
import '../providers/order_history_notifier.dart';

/// Tampilan read-only untuk satu pesanan: item, catatan, total, status, outlet.
class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(orderDetailProvider(orderId));

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detail Pesanan',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 12),
                Text(
                  'Gagal memuat detail pesanan.',
                  style: GoogleFonts.inter(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ref.invalidate(orderDetailProvider(orderId)),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
        data: (detail) => _DetailBody(detail: detail),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail});

  final OrderDetail detail;

  @override
  Widget build(BuildContext context) {
    final status = FulfillmentStatus.fromString(detail.fulfillmentStatus);
    final statusLabel = status?.displayLabel ?? detail.fulfillmentStatus;
    final formattedDate = DateFormat('d MMM yyyy, HH:mm', 'id_ID')
        .format(detail.placedAt.toLocal());
    final outletDisplay = detail.outletName.isNotEmpty
        ? (detail.brandName != null
            ? '${detail.brandName} – ${detail.outletName}'
            : detail.outletName)
        : detail.orderNumber;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status icon + title header (same pattern as order tracking screen)
          if (status != null) _StatusHeader(status: status),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CANCELLED banner — outside stepper (CLAUDE.md §7.6)
                if (status == FulfillmentStatus.cancelled) ...[
                  _CancelledBanner(),
                  const SizedBox(height: 16),
                ],

                // 5-step fulfillment stepper
                if (status != null) ...[
                  _FulfillmentStepper(status: status),
                  const SizedBox(height: 16),
                ],

                // Header card: order number + status badge + outlet + date
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            detail.orderNumber,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          _StatusBadge(
                            status: detail.fulfillmentStatus,
                            label: statusLabel,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.storefront_outlined,
                              size: 14, color: AppColors.primary),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              outletDisplay,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: const Color(0xFF4A5568),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time_outlined,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            formattedDate,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Items card
                _Card(
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
                      ...detail.items.asMap().entries.map((entry) {
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
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName ?? '-',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      if (item.itemNotes != null &&
                                          item.itemNotes!.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2),
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
                      if (detail.notes != null &&
                          detail.notes!.isNotEmpty) ...[
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
                          detail.notes!,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Total card
                _Card(
                  child: _PriceSummary(detail: detail),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(String raw) {
    final n = double.tryParse(raw) ?? 0;
    return NumberFormat('#,###', 'id_ID').format(n.toInt());
  }
}

// ---------------------------------------------------------------------------
// Status header — matches order_tracking_screen's _StatusHeader
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
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
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
          const SizedBox(height: 14),
          Text(
            status.headerTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20,
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
// CANCELLED banner
// ---------------------------------------------------------------------------

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
// Fulfillment stepper — matches order_tracking_screen's _FulfillmentStepper
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
    final Color dotColor = isOn ? FeastColors.primary : Colors.grey.shade200;

    final Widget dotIcon;
    if (isCompleted) {
      dotIcon =
          const Icon(Icons.check_rounded, color: Colors.white, size: 16);
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
// Shared card + status badge
// ---------------------------------------------------------------------------

class _Card extends StatelessWidget {
  const _Card({required this.child});
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

/// Price breakdown: subtotal (derived from items) + tax + grand total.
class _PriceSummary extends StatelessWidget {
  const _PriceSummary({required this.detail});

  final OrderDetail detail;

  String _fmt(String raw) {
    final n = double.tryParse(raw) ?? 0;
    return NumberFormat('#,###', 'id_ID').format(n.toInt());
  }

  @override
  Widget build(BuildContext context) {
    final itemsSubtotal = detail.items.fold(0.0, (sum, item) {
      return sum + (double.tryParse(item.lineTotal) ?? 0);
    });

    return Column(
      children: [
        _PriceRow(
          label: 'Subtotal',
          value: 'Rp ${NumberFormat('#,###', 'id_ID').format(itemsSubtotal.toInt())}',
        ),
        if ((double.tryParse(detail.taxAmount ?? '0') ?? 0) > 0) ...[
          const SizedBox(height: 8),
          _PriceRow(label: 'Pajak', value: 'Rp ${_fmt(detail.taxAmount!)}'),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
        _PriceRow(
          label: 'Total Pembayaran',
          value: 'Rp ${_fmt(detail.grandTotal)}',
          isBold: true,
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value, this.isBold = false});

  final String label;
  final String value;
  final bool isBold;

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
            color: isBold ? const Color(0xFF1A1A1A) : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isBold ? 18 : 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.label});
  final String status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      'COMPLETED' => (const Color(0xFFD1FAE5), const Color(0xFF065F46)),
      'CANCELLED' => (const Color(0xFFF2F2F2), const Color(0xFF828282)),
      _ => (const Color(0xFFFDE8D1), const Color(0xFF9E763E)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}
