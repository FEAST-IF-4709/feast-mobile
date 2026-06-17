import 'package:flutter/material.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/personal_info_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // PROFILE CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 3,
                        ),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/profile.png"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dandi",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "dandi@example.com",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.grey.shade700,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.025,
                              vertical: MediaQuery.of(context).size.width * 0.015,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade400,
                                  Colors.grey.shade200,
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.workspace_premium,
                                  size: MediaQuery.of(context).size.width * 0.038,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Silver Tier",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.030,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEFE3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // REWARD CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE8D7B3),
                      Color(0xFFD9B58A),
                      Color(0xFFEED9B5),
                      Color(0xFFD7B18A),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(
                        Icons.star_border_rounded,
                        size: MediaQuery.of(context).size.width * 0.1
                        ,
                        color: Colors.amber.shade700,
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FEAST Rewards",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "You're 250 pts away from Gold!",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.width * 0.05,),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1,250",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.07,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  "POINTS BALANCE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width * 0.03,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              padding:
                              EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.05,
                                vertical: MediaQuery.of(context).size.width * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(40),
                              ),
                              child: Text(
                                "Redeem",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.032,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // SETTINGS CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
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
                    Text(
                      "ACCOUNT & SETTINGS",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.brown.shade700,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),

                    buildMenuItem(
                      context,
                      Icons.person_outline,
                      "Personal Information",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PersonalInfoScreen()),
                        );
                      },
                    ),

                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),

                    // TODO(M7): Notifications — FCM out of scope for M1–M8 (PRD §8)
                    buildMenuItem(
                      context,
                      Icons.notifications_none_rounded,
                      "Notifications",
                    ),

                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),

                    // TODO(M7): Security & Privacy — no PRD equivalent in Phase 1
                    buildMenuItem(
                      context,
                      Icons.shield_outlined,
                      "Security & Privacy",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // LOGOUT
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.05),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0E0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      size: MediaQuery.of(context).size.width * 0.045,
                      Icons.logout,
                      color: Colors.red.shade800,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.orange.shade800,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.brown.shade300,
          ),
        ],
      ),
    );
  }
}