import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../brands/providers/brand_notifier.dart';
import '../../checkout/data/order_repository.dart';
import '../../checkout/providers/active_order_notifier.dart';
import '../../qr_session/providers/qr_session_notifier.dart';
import '../domain/cart_item.dart';
import '../providers/cart_notifier.dart';

/// Cart screen — shows all items, per-item notes, order notes, and total.
///
/// "Pesan Sekarang" calls [OrderRepository.createOrder] and navigates to
/// the Payment screen on success. On failure the cart is preserved and an
/// error snackbar is shown.
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final _orderNotesController = TextEditingController();
  bool _isPlacingOrder = false;

  /// Non-null when a voucher/promo has been applied (discount amount in IDR).
  double? _voucherDiscount;

  @override
  void dispose() {
    _orderNotesController.dispose();
    super.dispose();
  }

  String _formatPrice(double price) =>
      NumberFormat('#,###', 'id_ID').format(price.toInt());

  Future<void> _placeOrder() async {
    final messenger = ScaffoldMessenger.of(context);
    final session = await ref.read(qrSessionNotifierProvider.future);
    if (session == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Sesi meja tidak ditemukan. Scan QR lagi.')),
      );
      return;
    }

    final items = ref.read(cartNotifierProvider);
    if (items.isEmpty) return;

    setState(() => _isPlacingOrder = true);
    try {
      final result = await ref.read(orderRepositoryProvider).createOrder(
            tableId: session.tableId,
            items: items,
            notes: _orderNotesController.text.trim().isEmpty
                ? null
                : _orderNotesController.text.trim(),
          );
      ref.read(cartNotifierProvider.notifier).clearCart();
      await ref
          .read(activeOrderNotifierProvider.notifier)
          .setActiveOrder(result.orderId);
      if (mounted) {
        context.go(
          '/payment/${result.orderId}',
          extra: {
            'orderNumber': result.orderNumber,
            'subtotal': result.subtotal,
            'discountTotal': result.discountTotal,
            'taxAmount': result.taxAmount,
            'grandTotal': result.grandTotal,
          },
        );
      }
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } finally {
      if (mounted) setState(() => _isPlacingOrder = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(cartNotifierProvider);
    final notifier = ref.read(cartNotifierProvider.notifier);
    final subtotal = notifier.totalAmount;
    final total = subtotal + subtotal * 0.1;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0ED),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Keranjang',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: items.isEmpty
          ? _buildEmpty(context)
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBrandHeader(),
                  const SizedBox(height: 8),
                  _buildItemsSection(items, notifier, screenWidth),
                  const SizedBox(height: 8),
                  _buildVoucherRow(screenWidth),
                  const SizedBox(height: 8),
                  _buildOrderNotesSection(screenWidth),
                  const SizedBox(height: 8),
                  _buildPaymentSummary(subtotal, screenWidth),
                  const SizedBox(height: 120),
                ],
              ),
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : _buildBottomBar(context, total, screenWidth),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Keranjang kosong',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(
            'Pilih menu terlebih dahulu',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: FeastColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            child: Text(
              'Lihat Menu',
              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandHeader() {
    final sessionAsync = ref.watch(qrSessionNotifierProvider);
    final brandsAsync = ref.watch(brandNotifierProvider);

    return sessionAsync.maybeWhen(
      data: (session) {
        if (session == null) return const SizedBox.shrink();

        final logoUrl = brandsAsync.maybeWhen(
          data: (brands) {
            try {
              return brands.firstWhere((b) => b.id == session.brandId).logoUrl;
            } catch (_) {
              return null;
            }
          },
          orElse: () => null,
        );

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              _BrandLogo(logoUrl: logoUrl, brandName: session.brandName),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.brandName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: const Color(0xFF261D18),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.table_bar_outlined,
                            size: 14, color: Color(0xFF8B6A5A)),
                        const SizedBox(width: 4),
                        Text(
                          'Meja ${session.tableLabel}',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF8B6A5A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildItemsSection(
      List<CartItem> items, CartNotifier notifier, double screenWidth) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...items.map((item) => _buildItemCard(item, notifier)),
        ],
      ),
    );
  }

  Widget _buildItemCard(CartItem item, CartNotifier notifier) {
    final unitPrice = double.tryParse(item.effectivePrice) ?? 0;
    final subtotal = unitPrice * item.quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: item.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: item.imageUrl!,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        placeholder: (_, _) =>
                            Container(color: const Color(0xFFF5E6D8)),
                        errorWidget: (_, _, _) => _ImageFallback(size: 72),
                      )
                    : _ImageFallback(size: 72),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: const Color(0xFF261D18),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Rp ${_formatPrice(subtotal)}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: FeastColors.primary,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        _QtyButton(
                          icon: Icons.remove,
                          onTap: () => notifier.updateQuantity(
                              item.outletProductId, item.quantity - 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '${item.quantity}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        _QtyButton(
                          icon: Icons.add,
                          onTap: () => notifier.updateQuantity(
                              item.outletProductId, item.quantity + 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 84),
            child: _ItemNotesField(
              initialValue: item.itemNotes ?? '',
              onChanged: (v) =>
                  notifier.updateItemNotes(item.outletProductId, v),
            ),
          ),
          Divider(height: 20, thickness: 1, color: Colors.grey.shade100),
        ],
      ),
    );
  }

  Widget _buildVoucherRow(double screenWidth) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fitur voucher segera hadir')),
        );
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF0E4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.confirmation_number_outlined,
                  size: 18, color: FeastColors.primary),
            ),
            const SizedBox(width: 12),
            Text(
              _voucherDiscount != null
                  ? 'Voucher diterapkan'
                  : 'Pakai Promo/Voucher',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF261D18),
              ),
            ),
            const Spacer(),
            Text(
              _voucherDiscount != null ? 'Ubah' : 'Pilih',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: FeastColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderNotesSection(double screenWidth) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Catatan Pesanan',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF261D18),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _orderNotesController,
            maxLines: 2,
            maxLength: 500,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Contoh: jangan terlalu pedas, tambah sambal',
              hintStyle:
                  GoogleFonts.inter(color: Colors.grey.shade400, fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFFAF5F2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              counterText: '',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(double subtotal, double screenWidth) {
    final serviceFee = subtotal * 0.1;
    final total = subtotal + serviceFee;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: 16),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', subtotal, isDiscount: false),
          const SizedBox(height: 10),
          _buildSummaryRow('Biaya Layanan (10%)', serviceFee, isDiscount: false),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color(0xFF261D18),
                ),
              ),
              Text(
                'Rp ${_formatPrice(total)}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: FeastColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value,
      {required bool isDiscount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 14, color: const Color(0xFF5D4F46)),
        ),
        Text(
          isDiscount ? '- Rp ${_formatPrice(value)}' : 'Rp ${_formatPrice(value)}',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Colors.green.shade700 : const Color(0xFF261D18),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, double total, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: _isPlacingOrder ? null : _placeOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: FeastColors.primary,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
          ),
          child: _isPlacingOrder
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pesan Sekarang',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
        ),
      ),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  final String? logoUrl;
  final String brandName;

  const _BrandLogo({required this.logoUrl, required this.brandName});

  @override
  Widget build(BuildContext context) {
    if (logoUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: logoUrl!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          placeholder: (_, _) => _initials(brandName),
          errorWidget: (_, _, _) => _initials(brandName),
        ),
      );
    }
    return _initials(brandName);
  }

  Widget _initials(String name) {
    final letter = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFDF0E4),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: FeastColors.primary,
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  final double size;
  const _ImageFallback({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: const Color(0xFFF5E6D8),
      child: const Icon(Icons.restaurant, color: Colors.white54, size: 28),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFFDF2E9),
          shape: BoxShape.circle,
          border: Border.all(color: FeastColors.primary),
        ),
        child: Icon(icon, color: FeastColors.primary, size: 15),
      ),
    );
  }
}

/// Compact per-item note: shows "Tambah Catatan" link collapsed, expands on tap.
class _ItemNotesField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _ItemNotesField({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<_ItemNotesField> createState() => _ItemNotesFieldState();
}

class _ItemNotesFieldState extends State<_ItemNotesField> {
  late final TextEditingController _controller;
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _expanded = widget.initialValue.isNotEmpty;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_expanded) {
      return GestureDetector(
        onTap: () => setState(() => _expanded = true),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit_note_outlined,
                size: 16, color: Color(0xFF8B6A5A)),
            const SizedBox(width: 4),
            Text(
              'Tambah Catatan',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF8B6A5A),
              ),
            ),
          ],
        ),
      );
    }

    return TextField(
      controller: _controller,
      maxLength: 255,
      maxLines: 2,
      autofocus: widget.initialValue.isEmpty,
      style: GoogleFonts.inter(fontSize: 12),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Catatan untuk item ini',
        hintStyle: GoogleFonts.inter(color: Colors.grey.shade400, fontSize: 12),
        filled: true,
        fillColor: const Color(0xFFFAF5F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        counterText: '',
      ),
    );
  }
}
