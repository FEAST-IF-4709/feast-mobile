import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_theme.dart';
import '../../order_tracking/providers/order_tracking_notifier.dart';
import '../providers/payment_notifier.dart';

/// Payment screen — shows QRIS code with real 15-minute countdown.
///
/// Auto-refreshes QR on expiry (via [PaymentNotifier]).
/// Navigates to Order Tracking when WebSocket fires SETTLED.
class PaymentScreen extends ConsumerWidget {
  final String orderId;
  final String orderNumber;
  final String subtotal;
  final String discountTotal;
  final String taxAmount;
  final String grandTotal;

  const PaymentScreen({
    super.key,
    required this.orderId,
    required this.orderNumber,
    required this.subtotal,
    required this.discountTotal,
    required this.taxAmount,
    required this.grandTotal,
  });

  String _formatPrice(String raw) {
    final val = double.tryParse(raw) ?? 0;
    return NumberFormat('#,###', 'id_ID').format(val.toInt());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // OrderTrackingNotifier owns the single WS; listen here for payment settled.
    ref.listen(orderTrackingNotifierProvider(orderId), (_, next) {
      if ((next.value?.paymentSettled ?? false) && context.mounted) {
        context.go(
          '/order-tracking/$orderId',
          extra: {'orderNumber': orderNumber},
        );
      }
    });

    final qrisAsync = ref.watch(paymentNotifierProvider(orderId));

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Pembayaran',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Order summary card
            _OrderSummaryCard(
              orderNumber: orderNumber,
              subtotal: _formatPrice(subtotal),
              discountTotal: _formatPrice(discountTotal),
              taxAmount: _formatPrice(taxAmount),
              grandTotal: _formatPrice(grandTotal),
            ),
            const SizedBox(height: 20),

            // QRIS card
            qrisAsync.when(
              loading: () => const _QrisLoadingCard(),
              error: (e, _) => _QrisErrorCard(
                message: e.toString(),
                onRetry: () =>
                    ref.invalidate(paymentNotifierProvider(orderId)),
              ),
              data: (qris) => _QrisActiveCard(
                orderId: orderId,
                qrString: qris.qrString,
                expiresAt: qris.expiresAt,
              ),
            ),

            const SizedBox(height: 30),

            // How to pay
            _HowToPaySection(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final String orderNumber;
  final String subtotal;
  final String discountTotal;
  final String taxAmount;
  final String grandTotal;

  const _OrderSummaryCard({
    required this.orderNumber,
    required this.subtotal,
    required this.discountTotal,
    required this.taxAmount,
    required this.grandTotal,
  });

  bool _isZero(String v) => (double.tryParse(v) ?? 0) == 0;

  @override
  Widget build(BuildContext context) {
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
        children: [
          Text(
            orderNumber,
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 12),
          _SummaryRow(label: 'Subtotal', value: 'Rp $subtotal'),
          if (!_isZero(discountTotal)) ...[
            const SizedBox(height: 6),
            _SummaryRow(
              label: 'Diskon',
              value: '- Rp $discountTotal',
              valueColor: Colors.green.shade700,
            ),
          ],
          if (!_isZero(taxAmount)) ...[
            const SizedBox(height: 6),
            _SummaryRow(label: 'Pajak', value: 'Rp $taxAmount'),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: Colors.grey.shade200),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Rp $grandTotal',
                style: GoogleFonts.inter(
                  color: FeastColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: valueColor ?? const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}

class _QrisLoadingCard extends StatelessWidget {
  const _QrisLoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          top: BorderSide(color: FeastColors.primary, width: 4),
        ),
      ),
      child: const Column(
        children: [
          CircularProgressIndicator(color: FeastColors.primary),
          SizedBox(height: 16),
          Text('Memuat kode QRIS…'),
        ],
      ),
    );
  }
}

class _QrisErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _QrisErrorCard({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          top: BorderSide(color: Colors.red, width: 4),
        ),
      ),
      child: Column(
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
    );
  }
}

class _QrisActiveCard extends ConsumerStatefulWidget {
  final String orderId;
  final String qrString;
  final DateTime expiresAt;

  const _QrisActiveCard({
    required this.orderId,
    required this.qrString,
    required this.expiresAt,
  });

  @override
  ConsumerState<_QrisActiveCard> createState() => _QrisActiveCardState();
}

class _QrisActiveCardState extends ConsumerState<_QrisActiveCard> {
  bool _isSaving = false;
  bool _isSharing = false;

  Future<Uint8List?> _generateQrBytes() async {
    const double qrSize = 512;
    const double padding = 32;
    const double total = qrSize + padding * 2;

    final painter = QrPainter(
      data: widget.qrString,
      version: QrVersions.auto,
      gapless: true,
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // White background so the PNG is never transparent/black
    canvas.drawRect(
      Rect.fromLTWH(0, 0, total, total),
      Paint()..color = Colors.white,
    );

    // Translate so the QR sits centred inside the padding
    canvas.translate(padding, padding);
    painter.paint(canvas, const Size(qrSize, qrSize));

    final picture = recorder.endRecording();
    final image = await picture.toImage(total.toInt(), total.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _downloadQr() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    try {
      final bytes = await _generateQrBytes();
      if (bytes == null) throw Exception('Gagal membuat gambar QR');
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }
      await Gal.putImageBytes(bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR berhasil disimpan ke galeri')),
        );
      }
    } on GalException catch (e) {
      if (mounted) {
        final msg = e.type == GalExceptionType.accessDenied
            ? 'Izin akses galeri ditolak'
            : 'Gagal menyimpan gambar';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _shareQr() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      final bytes = await _generateQrBytes();
      if (bytes == null) throw Exception('Gagal membuat gambar QR');
      await Share.shareXFiles(
        [
          XFile.fromData(
            bytes,
            name: 'qris_payment.png',
            mimeType: 'image/png',
          ),
        ],
        subject: 'Kode QRIS Pembayaran Feast',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal berbagi: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final countdownAsync = ref.watch(paymentCountdownProvider(widget.expiresAt));
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          top: BorderSide(color: FeastColors.primary, width: 4),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.qr_code_2, color: Color(0xFF9A5300)),
              const SizedBox(width: 8),
              Text(
                'Pembayaran QRIS',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Scan kode QR menggunakan aplikasi\ne-wallet atau mobile banking Anda.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.grey.shade600,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),

          // QR code rendered from raw QRIS string
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: QrImageView(
              data: widget.qrString,
              version: QrVersions.auto,
              size: screenWidth * 0.55,
              backgroundColor: Colors.white,
              errorStateBuilder: (_, _) => SizedBox(
                width: screenWidth * 0.55,
                height: screenWidth * 0.55,
                child: const Center(
                  child: Text('Gagal render QR'),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Countdown timer
          countdownAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (remaining) {
              final isExpired = remaining == Duration.zero;
              final mm =
                  remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
              final ss =
                  remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isExpired
                      ? Colors.orange.shade50
                      : const Color(0xFFFFEBEB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: isExpired ? Colors.orange : Colors.red,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isExpired
                          ? 'QR kadaluarsa — memuat ulang…'
                          : 'Berlaku $mm:$ss',
                      style: GoogleFonts.inter(
                        color: isExpired ? Colors.orange : Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Download & Share actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isSaving ? null : _downloadQr,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: FeastColors.primary,
                          ),
                        )
                      : const Icon(Icons.download_outlined, size: 18),
                  label: Text(
                    _isSaving ? 'Menyimpan…' : 'Simpan',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: FeastColors.primary,
                    side: const BorderSide(color: FeastColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 48),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isSharing ? null : _shareQr,
                  icon: _isSharing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: FeastColors.primary,
                          ),
                        )
                      : const Icon(Icons.share_outlined, size: 18),
                  label: Text(
                    _isSharing ? 'Berbagi…' : 'Bagikan',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: FeastColors.primary,
                    side: const BorderSide(color: FeastColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 48),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HowToPaySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CARA BAYAR',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.grey.shade700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        _Step(
          number: '1',
          text: 'Buka aplikasi e-wallet atau mobile banking (GoPay, OVO, BCA, dll).',
        ),
        _Step(
          number: '2',
          text: 'Pilih fitur Scan QR / QRIS, lalu arahkan kamera ke kode di atas.',
        ),
        _Step(
          number: '3',
          text: 'Konfirmasi pembayaran di aplikasi Anda. Pesanan akan otomatis diproses.',
        ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final String number;
  final String text;

  const _Step({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFFDF2E9),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number,
                  style: GoogleFonts.inter(
                    color: FeastColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
