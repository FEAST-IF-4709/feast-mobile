import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vouchers = [
      {
        'name': "Aldi's Burger",
        'amount': '100.000',
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=300&auto=format&fit=crop'
      },
      {
        'name': "Liceria's Pizzaria",
        'amount': '200.000',
        'image': 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?q=80&w=300&auto=format&fit=crop'
      },
      {
        'name': "Uncle John Coffee",
        'amount': '50.000',
        'image': 'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=300&auto=format&fit=crop'
      },
      {
        'name': "Sushi Restaurant",
        'amount': '250.000',
        'image': 'https://images.unsplash.com/photo-1553621042-f6e147245754?q=80&w=300&auto=format&fit=crop'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Voucher (40)',
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Brand', style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
                        const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.percent, color: Colors.white, size: 14),
                        ),
                        const SizedBox(width: 8),
                        Text('Voucher Code', style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                final v = vouchers[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias, // Ensures image corners conform to the container
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'FEAST',
                                style: GoogleFonts.inter(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                v['name']!,
                                style: GoogleFonts.inter(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      'Rp ',
                                      style: GoogleFonts.inter(color: Colors.black87, fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    v['amount']!,
                                    style: GoogleFonts.inter(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  //   decoration: BoxDecoration(
                                  //     color: AppColors.primary,
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  //   child: Text(
                                  //     'USE',
                                  //     style: GoogleFonts.inter(
                                  //       color: Colors.white,
                                  //       fontSize: 9,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        color: const Color(0xFFD36C00), // Slightly darker orange for contrast
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              'a day left',
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 140, // Increased image width slightly to match proportion
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(v['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
