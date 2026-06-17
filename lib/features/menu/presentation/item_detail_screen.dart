import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../cart/domain/cart_item.dart';
import '../../cart/providers/cart_notifier.dart';
import '../domain/menu_item.dart';

class ItemDetailScreen extends ConsumerStatefulWidget {
  final MenuItem item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  ConsumerState<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen> {
  int _quantity = 1;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  String _formatPrice(String priceStr) {
    final price = double.tryParse(priceStr) ?? 0;
    return NumberFormat('#,###', 'id_ID').format(price.toInt());
  }

  void _addToCart() {
    ref.read(cartNotifierProvider.notifier).addItem(
          CartItem(
            outletProductId: widget.item.outletProductId,
            name: widget.item.name,
            effectivePrice: widget.item.effectivePrice,
            quantity: _quantity,
            itemNotes: _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
            imageUrl: widget.item.imageUrl,
          ),
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final item = widget.item;
    final unitPrice = double.tryParse(item.effectivePrice) ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          item.name,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item image
            if (item.imageUrl != null)
              CachedNetworkImage(
                imageUrl: item.imageUrl!,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(
                  height: 240,
                  color: const Color(0xFFF5E6D8),
                ),
                errorWidget: (_, _, _) => Container(
                  height: 240,
                  color: const Color(0xFFF5E6D8),
                  child: const Icon(Icons.restaurant, size: 64, color: Colors.white),
                ),
              )
            else
              Container(
                height: 240,
                width: double.infinity,
                color: const Color(0xFFF5E6D8),
                child: const Icon(Icons.restaurant, size: 64, color: Colors.white),
              ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + availability badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!item.stockAvailable)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            'Habis',
                            style: GoogleFonts.inter(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Price
                  Text(
                    'Rp ${_formatPrice(item.effectivePrice)}',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: FeastColors.primary,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Quantity selector
                  Text(
                    'Jumlah',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        onTap: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '$_quantity',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add,
                        onTap: _quantity < 99
                            ? () => setState(() => _quantity++)
                            : null,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Item notes
                  Text(
                    'Catatan (opsional)',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _notesController,
                    maxLength: 255,
                    maxLines: 3,
                    style: GoogleFonts.inter(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Contoh: tanpa pedas, tanpa bawang…',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: FeastColors.primary),
                      ),
                      counterText: '',
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),

      // Add to cart button
      bottomNavigationBar: Container(
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
        child: ElevatedButton(
          onPressed: item.stockAvailable ? _addToCart : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: FeastColors.primary,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
          ),
          child: Text(
            item.stockAvailable
                ? 'Tambah ke Keranjang  —  Rp ${_formatPrice((unitPrice * _quantity).toStringAsFixed(0))}'
                : 'Menu Habis',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFFDF2E9) : Colors.grey.shade100,
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? FeastColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Icon(
          icon,
          color: enabled ? FeastColors.primary : Colors.grey,
          size: 20,
        ),
      ),
    );
  }
}
