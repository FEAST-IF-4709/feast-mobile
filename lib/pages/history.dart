import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class HistoryPage extends StatelessWidget {
  final String username;

  const HistoryPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 32),
                Text(
                  'Order History',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Review and manage your past meals.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      _buildFilterChip(Icons.calendar_today_outlined, 'Last 30 Days'),
                      const SizedBox(width: 12),
                      _buildFilterChip(Icons.storefront_outlined, 'All Restaurants'),
                      const SizedBox(width: 12),
                      _buildFilterChip(Icons.file_download_outlined, 'Export', isAction: true),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildHistoryCard(
                  logoUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
                  restaurantName: 'Aldi’s Burger',
                  date: 'Oct 24, 2023 • 1:15 PM',
                  items: [
                    {'qty': '2x', 'name': 'Truffle Smash Burger', 'price': 'Rp100.000'},
                    {'qty': '1x', 'name': 'Sweet Potato Fries', 'price': 'Rp25.000'},
                  ],
                  total: 'Rp125.000',
                  status: 'DELIVERED',
                  statusColor: const Color(0xFFFDE8D1),
                  statusTextColor: const Color(0xFF9E763E),
                  showReorder: true,
                ),
                const SizedBox(height: 24),
                _buildHistoryCard(
                  logoUrl: 'https://cdn-icons-png.flaticon.com/512/2737/2737034.png',
                  restaurantName: 'Uncle John Cafe',
                  date: 'Oct 18, 2023 • 7:45 PM',
                  items: [
                    {'qty': '1x', 'name': 'Mixed Grill Platter', 'price': 'Rp100.000'},
                  ],
                  total: 'Rp100.000',
                  status: 'CANCELLED',
                  statusColor: const Color(0xFFF2F2F2),
                  statusTextColor: const Color(0xFF828282),
                  showReorder: false,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200, width: 1),
            image: const DecorationImage(
              image: NetworkImage('https://i.pravatar.cc/150?img=11'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${username[0].toUpperCase()}${username.substring(1)}',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            Text(
              'Silver Membership',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFFA0AEC0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.primary,
            size: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(IconData icon, String label, {bool isAction = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF4A5568)),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4A5568),
            ),
          ),
          if (!isAction) ...[
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF4A5568)),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryCard({
    required String logoUrl,
    required String restaurantName,
    required String date,
    required List<Map<String, String>> items,
    required String total,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    bool showReorder = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(logoUrl, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantName,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: const Color(0xFF718096),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: statusTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const DashedDivider(),
                const SizedBox(height: 20),
                ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Text(
                        item['qty']!,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item['name']!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: const Color(0xFF718096),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        item['price']!,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: const Color(0xFF718096),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                    Text("Total Paid", style: TextStyle(fontSize: 12,)),
                    Text(total, style: TextStyle(fontSize: 18, fontWeight: FontWeight(600)),)
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.receipt_long_outlined, size: 12, color: Color(0xFF1A1A1A),),
                          const SizedBox(width: 3),
                          Text("Bill PDF", style: TextStyle(fontSize: 12, color: Color(0xFF1A1A1A)),)
                        ],
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFDD7A00),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.restart_alt_sharp, size: 12, color: Colors.white,),
                          const SizedBox(width: 3,),
                          Text("Reorder", style: TextStyle(fontSize: 12, color: Colors.white),)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            // child: Row(
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Total Paid',
            //           style: GoogleFonts.plusJakartaSans(
            //             fontSize: 12,
            //             color: const Color(0xFF718096),
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         const SizedBox(height: 2),
            //         Text(
            //           total,
            //           style: GoogleFonts.plusJakartaSans(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w800,
            //             color: const Color(0xFF1A1A1A),
            //           ),
            //         ),
            //       ],
            //     ),
            //     const Spacer(),
            //     if (showReorder) ...[
            //       OutlinedButton.icon(
            //         onPressed: () {},
            //         icon: const Icon(Icons.receipt_long_outlined, size: 12),
            //         label: const Text('Bill PDF'),
            //         style: OutlinedButton.styleFrom(
            //           foregroundColor: const Color(0xFF1A1A1A),
            //           side: const BorderSide(color: Color(0xFFE2E8F0)),
            //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //           backgroundColor: Colors.white,
            //         ),
            //       ),
            //       // const SizedBox(width: 10),
            //       ElevatedButton.icon(
            //         onPressed: () {},
            //         icon: const Icon(Icons.refresh_rounded, size: 18),
            //         label: const Text('Reorder'),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: AppColors.primary,
            //           foregroundColor: Colors.white,
            //           elevation: 0,
            //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //         ),
            //       ),
            //     ] else
            //       OutlinedButton.icon(
            //         onPressed: () {},
            //         icon: const Icon(Icons.receipt_long_outlined, size: 18),
            //         label: const Text('Details'),
            //         style: OutlinedButton.styleFrom(
            //           foregroundColor: const Color(0xFF1A1A1A),
            //           side: const BorderSide(color: Color(0xFFE2E8F0)),
            //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //           backgroundColor: Colors.white,
            //         ),
            //       ),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }
}

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.color = const Color(0xFFE2E8F0),
    this.dashWidth = 4,
    this.dashSpace = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

