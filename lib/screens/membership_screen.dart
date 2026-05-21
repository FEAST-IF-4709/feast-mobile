import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class MembershipScreen extends StatelessWidget {
  MembershipScreen({super.key});

  final List<String> tiers = ["bronze", "silver", "gold"];
  final String currentTier = "silver";

  final Map<String, List<String>> tierBenefits = {
    "bronze": ["Earn 1 pts per \$1 spent", "Birthday treat", "App Ordering"],
    "silver": [
      "Earn 1.5 pts per \$1 spent",
      "Free Delivery on app",
      "Monthly Silver Voucher",
      "Early access to new items",
    ],
    "gold": ["Earn 2.0 pts per \$1 spent", "Free Delivery on app", "Priority Support", "Exclusive Events Access"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5), // Soft cream background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Membership",
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "FEAST Rewards",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Unlock exclusive dining perks and experiences as you level up.",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 340, // Reduced height for the cards area
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: tiers.map((t) {
                    final isCurrent = t == currentTier;
                    final benefits = tierBenefits[t] ?? [];

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isCurrent ? AppColors.primary : Colors.grey.withOpacity(0.2),
                          width: 2,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "CURRENT TIER",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t[0].toUpperCase() + t.substring(1),
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 26,
                                      color: isCurrent ? AppColors.primary : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "You are a $t member",
                                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.stars, color: AppColors.primary, size: 30),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ...benefits.map((benefit) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: isCurrent ? AppColors.primary : Colors.grey[400], size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        benefit,
                                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Progress to Gold", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18)),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "550 ", style: GoogleFonts.inter(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                              TextSpan(text: "/ 1000 pts", style: GoogleFonts.inter(color: Colors.grey, fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("Earn 450 more points to level up", style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.55,
                        minHeight: 10,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.receipt_long, color: AppColors.primary, size: 20),
                        const SizedBox(width: 8),
                        Text("Order to earn points", style: GoogleFonts.inter(fontSize: 13, color: Colors.black87)),
                        const Spacer(),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: AppColors.primary,
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        //     elevation: 0,
                        //   ),
                        //   child: Text("ORDER NOW", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12)),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Silver Benefits",
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
