import 'package:feast/pages/profiles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import 'voucher_screen.dart';
import 'membership_screen.dart';
import 'scan_qr_screen.dart';
import '../pages/restaurants.dart';
import '../pages/history.dart';
import '../data/dummy_data.dart';
import '../screens/detailpage.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),
      MenuPage(username: widget.username),
      HistoryPage(username: widget.username),
      ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: pages[_selectedIndex],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanQrScreen()),
          );
        },
        child: Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1, style: BorderStyle.none),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.5, style: BorderStyle.solid),
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.grey,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildAppBar(),
            const SizedBox(height: 24),
            _buildCards(context),
            const SizedBox(height: 24),
            _currentOrder(),
            const SizedBox(height: 24),
            Text(
              'Hot Deals 🔥',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildHotDeals(),
            const SizedBox(height: 24),
            Text(
              'Where do you want to eat?',
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildRestaurant(context),
            const SizedBox(height: 16), // Space for bottom bar
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      },
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, ${widget.username[0].toUpperCase()}${widget.username.substring(1)}',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Silver Membership',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.primary,
                size: 28,
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const Icon(
            Icons.settings_outlined,
            color: AppColors.primary,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Row(
      children: [
        // LEFT CARD
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MembershipScreen()
                ),
              );
            },

            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.04,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.06,
                ),
                border: Border.all(
                  color: const Color(0xFFF1DDD1),
                  width: MediaQuery.of(context).size.width * 0.004,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                          Icons.workspace_premium_outlined,
                          color: Colors.grey.shade700,
                          size:
                          MediaQuery.of(context).size.width * 0.05
                      ),

                      SizedBox(
                        width:
                        MediaQuery.of(context).size.width * 0.005,
                      ),

                      Text(
                        "Silver Tier",
                        style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width *
                              0.03,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9A5300),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    MediaQuery.of(context).size.width * 0.04,
                  ),

                  Text(
                    "100",
                    style: TextStyle(
                      fontSize:
                      MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE07B00),
                      height: 1,
                    ),
                  ),

                  SizedBox(
                    height:
                    MediaQuery.of(context).size.width * 0.01,
                  ),

                  Text(
                    "Available Points",
                    style: TextStyle(
                      fontSize:
                      MediaQuery.of(context).size.width *
                          0.03,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          )
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02
          ,
        ),

        // RIGHT CARD
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VoucherPage()
                ),
              );
            },

            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.06,
                ),
                border: Border.all(
                  color: const Color(0xFFF1DDD1),
                  width: MediaQuery.of(context).size.width * 0.004,
                ),
              ),
              child: Stack(
                children: [

                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.confirmation_number_outlined,
                            color: const Color(0xFFE07B00),
                            size:
                            MediaQuery.of(context).size.width *
                                0.05,
                          ),

                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width *
                                0.015,
                          ),

                          Text(
                            "Vouchers",
                            style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2B1C14),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height:
                        MediaQuery.of(context).size.width *
                            0.045,
                      ),

                      Text(
                        "20 Active",
                        style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width *
                              0.045,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2B1C14),
                          height: 1,
                        ),
                      ),

                      SizedBox(
                        height:
                        MediaQuery.of(context).size.width *
                            0.02,
                      ),

                      Row(
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(
                              fontSize:
                              MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFE07B00),
                            ),
                          ),

                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width *
                                0.01,
                          ),

                          Icon(
                            Icons.chevron_right,
                            color: const Color(0xFFE07B00),
                            size:
                            MediaQuery.of(context).size.width *
                                0.045,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }

  Widget _buildHotDeals() {
    final List<Map<String, String>> menuList = [
      {
        "title": "Spicy Chicken Wings",
        "desc": "Chicken, Fries and Cola",
        "price": "Rp 55.000",
        "image": "https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec",
      },
      {
        "title": "Beef Burger",
        "desc": "Beef, Cheese and Fries",
        "price": "Rp 45.000",
        "image": "https://images.unsplash.com/photo-1550547660-d9450f859349",
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: menuList.map((menu) {
          return Row(
            children: [
              Container(
                width: 256,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 128,
                      width: 256,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(menu["image"]!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      width: 256,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu["title"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            menu["desc"]!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                menu["price"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFDD7A00),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDD7A00),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
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
              const SizedBox(width: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFoodCategories() {
    final categories = [
      {'name': 'SUSHI', 'color': const Color(0xFFFFE5E5), 'icon': Icons.set_meal},
      {'name': 'BURGER', 'color': const Color(0xFFFFF000), 'icon': Icons.fastfood},
      {'name': 'PIZZA', 'color': const Color(0xFFFFCCB3), 'icon': Icons.local_pizza},
      {'name': 'CAKE', 'color': const Color(0xFFFF8080), 'icon': Icons.cake},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((category) {
        return Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: category['color'] as Color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  category['icon'] as IconData,
                  color: Colors.black87,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'] as String,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRestaurant(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        // mainAxisSpacing: 5,
        childAspectRatio: 0.55,
      ),

      itemCount: 4,

      itemBuilder: (context, index) {
        final restaurant = restaurants[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantDetailPage(restaurant: restaurant)
              ),
            );
          },
          child:  Column(
            children: [
              Container(
                width:
                MediaQuery.of(context).size.width * 0.2,

                height:
                MediaQuery.of(context).size.width * 0.2,

                decoration: BoxDecoration(
                  color: restaurant['color'] as Color,
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                child: Center(
                  child: Icon(
                    restaurant['icon'] as IconData,
                    color: Colors.black87,
                    size:
                    MediaQuery.of(context).size.width *
                        0.08,
                  ),
                ),
              ),

              SizedBox(
                height:
                MediaQuery.of(context).size.width *
                    0.02,
              ),

              Text(
                restaurant['name'] as String,

                textAlign: TextAlign.center,

                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style: GoogleFonts.inter(
                  fontSize:
                  MediaQuery.of(context).size.width *
                      0.028,

                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _currentOrder() {
    return Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFDD7A00),
              Color(0xFFE0881B),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.set_meal,
                    color: Color(0xFFDD7A00),
                    size: 25,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("PREPARING ORDER...", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 12,)),
                        const Text("Liceria’s Piezzeria", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18,)),
                        const Text("Estimated: 15-20 mins", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12,)),
                      ]
                  )
              )
            ]
        )
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 20,
      shadowColor: Colors.black.withOpacity(0.5),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? Colors.white : Colors.grey,
                  size: 28,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.room_service_outlined,
                  color: _selectedIndex == 1 ? Colors.white : Colors.grey,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 48),
            GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  color: _selectedIndex == 2 ? Colors.white : Colors.grey,
                  size: 28,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(3),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selectedIndex == 3 ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  color: _selectedIndex == 3 ? Colors.white : Colors.grey,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
