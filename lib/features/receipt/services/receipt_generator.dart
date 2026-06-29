import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../order_history/domain/order_detail.dart';
import '../../../shared/utils/url_utils.dart';

/// Generates and distributes a PDF receipt for an [OrderDetail].
///
/// Uses the `printing` package for both the native print/save dialog
/// ([printOrSave]) and the OS share sheet ([share]).
class ReceiptGenerator {
  static final _numFmt = NumberFormat('#,###', 'id_ID');

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  static Future<void> printOrSave(OrderDetail detail) async {
    final bytes = await _build(detail);
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }

  static Future<void> share(OrderDetail detail) async {
    final bytes = await _build(detail);
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'struk_${detail.orderNumber}.pdf',
    );
  }

  // ---------------------------------------------------------------------------
  // PDF builder
  // ---------------------------------------------------------------------------

  static Future<Uint8List> _build(OrderDetail detail) async {
    final doc = pw.Document();

    // Pre-build the logo widget — download bytes directly so we control
    // timeouts and error handling. Falls through to the letter placeholder.
    pw.Widget? logoWidget;
    final rawLogoUrl = detail.brandLogoUrl;
    if (rawLogoUrl != null && rawLogoUrl.isNotEmpty) {
      final url = fixMediaUrl(rawLogoUrl);
      if (url != null) {
        final bytes = await _fetchImageBytes(url);
        if (bytes != null) {
          logoWidget = pw.ClipOval(
            child: pw.Image(
              pw.MemoryImage(bytes),
              width: 56,
              height: 56,
              fit: pw.BoxFit.cover,
            ),
          );
        }
      }
    }

    final formattedDate = DateFormat('d MMM yyyy, HH:mm', 'id_ID')
        .format(detail.placedAt.toLocal());

    final itemsSubtotal = detail.items.fold(
      0.0,
      (sum, item) => sum + (double.tryParse(item.lineTotal) ?? 0),
    );
    final tax = double.tryParse(detail.taxAmount ?? '0') ?? 0;
    final grandTotal = double.tryParse(detail.grandTotal) ?? 0;

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5.copyWith(
          marginTop: 24,
          marginBottom: 24,
          marginLeft: 24,
          marginRight: 24,
        ),
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            pw.Center(
              child: pw.Column(
                children: [
                  if (logoWidget != null)
                    logoWidget
                  else
                    pw.Container(
                      width: 56,
                      height: 56,
                      decoration: pw.BoxDecoration(
                        color: const PdfColor.fromInt(0xFFDD7A00),
                        shape: pw.BoxShape.circle,
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          (detail.brandName ?? 'F').substring(0, 1).toUpperCase(),
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 28,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    detail.brandName ?? detail.outletName,
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  if (detail.outletName.isNotEmpty &&
                      detail.brandName != null) ...[
                    pw.SizedBox(height: 2),
                    pw.Text(
                      detail.outletName,
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ],
                  if (detail.outletAddress != null &&
                      detail.outletAddress!.isNotEmpty) ...[
                    pw.SizedBox(height: 2),
                    pw.Text(
                      detail.outletAddress!,
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),

            pw.SizedBox(height: 14),
            _dashed(),
            pw.SizedBox(height: 10),

            // Order meta
            _metaRow('No. Order', '#${detail.orderNumber}'),
            pw.SizedBox(height: 4),
            _metaRow('Tanggal', formattedDate),

            pw.SizedBox(height: 10),
            _dashed(),
            pw.SizedBox(height: 10),

            // Items
            ...detail.items.map(
              (item) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 6),
                child: pw.Row(
                  children: [
                    pw.Text(
                      '${item.quantity}x ',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Expanded(
                      child: pw.Text(item.productName ?? '-'),
                    ),
                    pw.Text('Rp ${_numFmt.format((double.tryParse(item.lineTotal) ?? 0).toInt())}'),
                  ],
                ),
              ),
            ),

            pw.SizedBox(height: 10),
            _dashed(),
            pw.SizedBox(height: 10),

            // Price breakdown
            _priceRow('Subtotal', itemsSubtotal),
            if (tax > 0) ...[
              pw.SizedBox(height: 4),
              _priceRow('Pajak', tax),
            ],
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 6),

            // Grand total
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Pembayaran',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Rp ${_numFmt.format(grandTotal.toInt())}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                    color: const PdfColor.fromInt(0xFFDD7A00),
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 16),
            pw.Center(
              child: pw.Text(
                'Terima kasih atas pesananmu!',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return doc.save();
  }

  // ---------------------------------------------------------------------------
  // PDF layout helpers
  // ---------------------------------------------------------------------------

  static pw.Widget _dashed() => pw.Row(
        children: List.generate(
          30,
          (_) => pw.Expanded(
            child: pw.Container(
              height: 1,
              margin: const pw.EdgeInsets.symmetric(horizontal: 2),
              color: PdfColors.grey300,
            ),
          ),
        ),
      );

  static pw.Widget _metaRow(String label, String value) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 11)),
          pw.Text(value,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
        ],
      );

  static pw.Widget _priceRow(String label, double amount) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 12)),
          pw.Text(
            'Rp ${_numFmt.format(amount.toInt())}',
            style: const pw.TextStyle(fontSize: 12),
          ),
        ],
      );

  // ---------------------------------------------------------------------------
  // Image download helper
  // ---------------------------------------------------------------------------

  /// Downloads [url] and returns its raw bytes, or null on any failure.
  static Future<Uint8List?> _fetchImageBytes(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) return response.bodyBytes;
    } catch (_) {
      // Return null → caller falls back to letter placeholder.
    }
    return null;
  }
}
