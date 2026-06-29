import 'package:feast/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmOrderPage extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const ConfirmOrderPage({
    super.key,
    required this.restaurant,
  });

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  // Menggunakan warna dari desain sebelumnya
  final Color primaryOrange = const Color(0xFFE27C00);
  final Color titleColor = const Color(0xFF261D18);
  final Color descColor = const Color(0xFF5D4F46);
  final Color cardBorderColor = const Color(0xFFFDECE2);

  String selectedPaymentMethod = 'QRIS';

  void _showPaymentPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Method",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPaymentOption(
                    title: "QRIS",
                    subtitle: "Pay with any e-wallet or banking app",
                    icon: Icons.qr_code_2,
                    isSelected: selectedPaymentMethod == 'QRIS',
                    onTap: () {
                      setState(() => selectedPaymentMethod = 'QRIS');
                      setModalState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentOption(
                    title: "CASH",
                    subtitle: "Pay on Cashier",
                    icon: Icons.payments_outlined,
                    isSelected: selectedPaymentMethod == 'CASH',
                    onTap: () {
                      setState(() => selectedPaymentMethod = 'CASH');
                      setModalState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDF2E9) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryOrange : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryOrange, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? primaryOrange : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Inisialisasi MediaQuery
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Menghitung dynamic padding (misal 5% dari lebar layar)
    final double horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Confirm Order",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045, // Dynamic font size
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // 2. Order Summary Section
              _buildSectionTitle("Order Summary", screenWidth),
              SizedBox(height: screenHeight * 0.015),

              // Item 1
              _buildOrderItem(
                screenWidth: screenWidth,
                imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=400&auto=format&fit=crop',
                name: "Truffle Burger",
                notes: "No onions, extra mayo",
                price: "Rp 75.000",
                qty: 1,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Item 2

              SizedBox(height: screenHeight * 0.03),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Notes for Kitchen", style: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "e.g. Add extra cheese",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.035),
                      border: OutlineInputBorder(),

                    ),
                    maxLines: 3,
                  )
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              // TODO(M7): Vouchers out of scope for Phase 1 (PRD §8)
              GestureDetector(
                onTap: null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.025,
                    horizontal: screenWidth * 0.03,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFDD7A00), width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFDD7A00),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.confirmation_num_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select Voucher / Enter Code",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                              Text(
                                "Tap to apply discount",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right, color: Color(0xFFDD7A00), size: screenWidth * 0.08,)
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03,),

              GestureDetector(
                onTap: _showPaymentPicker,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.025,
                    horizontal: screenWidth * 0.03,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFDD7A00), width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Method",
                            style: TextStyle(
                                fontSize: screenWidth * 0.038,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Change",
                            style: TextStyle(
                                fontSize: screenWidth * 0.032,
                                color: const Color(0xFFDD7A00),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.02,
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 241, 233, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  selectedPaymentMethod == 'QRIS'
                                      ? Icons.qr_code_2
                                      : Icons.payments_outlined,
                                  color: const Color(0xFFDD7A00),
                                  size: screenWidth * 0.085,
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedPaymentMethod,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.045),
                                ),
                                SizedBox(height: screenWidth * 0.01),
                                Text(
                                  selectedPaymentMethod == 'QRIS'
                                      ? "Pay with any e-wallet or banking app"
                                      : "Pay on Cashier",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.025,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03,),

              // 3. Payment Summary
              _buildSectionTitle("Payment Details", screenWidth),
              SizedBox(height: screenHeight * 0.015),
              _buildPaymentRow("Subtotal", "Rp 185.000", screenWidth),
              SizedBox(height: screenHeight * 0.01),
              _buildPaymentRow("Delivery Fee", "Rp 15.000", screenWidth),
              SizedBox(height: screenHeight * 0.01),
              _buildPaymentRow("Platform Fee", "Rp 3.000", screenWidth),

              Divider(height: screenHeight * 0.04, thickness: 1, color: Colors.grey.shade200),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payment",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    "Rp 203.000",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      fontSize: screenWidth * 0.045,
                      color: primaryOrange,
                    ),
                  ),
                ],
              ),

              // Spacing ekstra di bawah agar tidak tertutup BottomNavigationBar
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),

      // 4. Sticky Bottom CTA (Call to Action)
      bottomNavigationBar: Container(
        height: screenHeight * 0.11, // Menggunakan 11% dari tinggi layar
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 10,
            )
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.06), // Dynamic border radius
            ),
            elevation: 0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          },
          child: Text(
            "Place Order - Rp 203.000",
            style: GoogleFonts.inter(
              fontSize: screenWidth * 0.045, // Dynamic font size
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget: Order Item Row
  Widget _buildOrderItem({
    required double screenWidth,
    required String imageUrl,
    required String name,
    required String notes,
    required String price,
    required int qty,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image dengan dynamic width
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),

        // Item Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                  color: const Color(0xFF261D18),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notes,
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.03,
                  color: const Color(0xFF5D4F46),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE27C00),
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ],
          ),
        ),

        // Quantity Indicator
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenWidth * 0.015,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFDECE2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "${qty}x",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE27C00),
              fontSize: screenWidth * 0.035,
            ),
          ),
        )
      ],
    );
  }

  // Helper Widget: Payment Row Details
  Widget _buildPaymentRow(String label, String value, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.035,
            color: const Color(0xFF5D4F46),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF261D18),
          ),
        ),
      ],
    );
  }

  // Helper Widget: Section Title
  Widget _buildSectionTitle(String title, double screenWidth) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: screenWidth * 0.045,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF261D18),
      ),
    );
  }
}
