import 'package:feast/screens/confirm_order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';



class RestaurantDetailPage extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailPage({
    super.key,
    required this.restaurant,
  });

  // Warna utama yang diambil dari desain
  final Color primaryOrange = const Color(0xFFE27C00);
  final Color badgeYellow = const Color(0xFFFFC107);


  @override
  Widget build(BuildContext context) {
    final List promoMenus = restaurant['menu']
        .where((item) => item['promo'] == true)
        .toList();

    String formatPrice(int price) {
      return NumberFormat('#,###', 'id_ID').format(price);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Image & Back Button (Menggantikan AppBar bawaan)
            Stack(
              children: [
                Image.network(
                  restaurant['logo'],
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 2. Restaurant Info Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: restaurant['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        restaurant['icon'] as IconData,
                        color: Colors.black87,
                        size:
                        MediaQuery
                            .of(context)
                            .size
                            .width *
                            0.08,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title & Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant['name'],
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Jalan Cempaka Putih",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Table Number Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBEBE4),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFEEDCD3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.table_bar_outlined, size: 16,
                            color: Color(0xFF8B5A43)),
                        const SizedBox(width: 6),
                        Text(
                          "#12",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF5A3A2A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  style: GoogleFonts.inter(),
                  decoration: const InputDecoration(
                    hintText: 'Search menu items...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Categories (Chips)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: restaurant['categories'].map<Widget>((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildCategoryChip(
                      category,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // 5. Promo Card Item
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item Image with Badge
                if (promoMenus.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade200),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),

                                child: Image.network(
                                  promoMenus[0]['image'],
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                top: 12,
                                left: 12,

                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),

                                  decoration: BoxDecoration(
                                    color: badgeYellow,
                                    borderRadius: BorderRadius.circular(4),
                                  ),

                                  child: Text(
                                    "PROMO",

                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16.0),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  promoMenus[0]['name'],

                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01),

                                Text(promoMenus[0]['description']),


                                SizedBox(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01),

                                Text(
                                  "Rp ${formatPrice(promoMenus[0]['price'])}",

                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Item Details
              ],
            ),

            // 6. Bottom Grid (Sisa menu di bawah)
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.55,
                ),

                itemCount: restaurant['menu'].length,

                itemBuilder: (context, index) {
                  final menuItem = restaurant['menu'][index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // IMAGE
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),

                            child: Stack(
                              children: [
                                Container(

                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(menuItem['image']),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                                // Image.network(
                                //   menuItem['image'],
                                //   width: double.infinity,
                                //   fit: BoxFit.cover,
                                // ),

                                if (menuItem['promo'] == true)
                                  Positioned(
                                    top: 10,
                                    left: 10,

                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),

                                      decoration: BoxDecoration(
                                        color: badgeYellow,
                                        borderRadius: BorderRadius.circular(6),
                                      ),

                                      child: Text(
                                        "PROMO",

                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // CONTENT
                        Padding(
                          padding: const EdgeInsets.all(12),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menuItem['name'],

                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                menuItem['description'],

                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "RP ${formatPrice(menuItem['price'])}",

                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryOrange,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.03,
                                    vertical: MediaQuery.of(context).size.width * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryOrange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ConfirmOrderPage(restaurant: restaurant)
                                        ),
                                      );
                                    },
                                  child: Center(
                                      child: Text(
                                        "Add",
                                        style: GoogleFonts.inter(
                                          fontSize: MediaQuery.of(context).size.width * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Chips Kategori
  Widget _buildCategoryChip(String text, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? primaryOrange : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive ? primaryOrange : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: isActive ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

}