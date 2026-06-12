import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailUpdates = true;
  bool _smsNotifications = false;
  bool _orderStatus = true;
  bool _promotionalOffers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notification Settings',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage how you receive alerts and updates from FEAST. Customizing these settings helps us keep you informed without being intrusive.',
              style: GoogleFonts.inter(
                color: Colors.grey.shade600,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            
            _buildNotificationTile(
              title: 'Push Notifications',
              subtitle: 'Direct alerts on your mobile device for real-time updates.',
              value: _pushNotifications,
              onChanged: (val) => setState(() => _pushNotifications = val),
            ),
            const SizedBox(height: 16),
            _buildNotificationTile(
              title: 'Email Updates',
              subtitle: 'Receive weekly newsletters and detailed account receipts via email.',
              value: _emailUpdates,
              onChanged: (val) => setState(() => _emailUpdates = val),
            ),
            const SizedBox(height: 16),
            _buildNotificationTile(
              title: 'SMS Notifications',
              subtitle: 'Get text messages for critical security alerts and verification codes.',
              value: _smsNotifications,
              onChanged: (val) => setState(() => _smsNotifications = val),
            ),
            const SizedBox(height: 16),
            _buildNotificationTile(
              title: 'Order Status Alerts',
              subtitle: 'Stay updated on your food preparation and delivery progress.',
              value: _orderStatus,
              onChanged: (val) => setState(() => _orderStatus = val),
            ),
            const SizedBox(height: 16),
            _buildNotificationTile(
              title: 'Promotional Offers',
              subtitle: 'Be the first to know about exclusive discounts and limited-time menu items.',
              value: _promotionalOffers,
              onChanged: (val) => setState(() => _promotionalOffers = val),
            ),
            
            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Preferences',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: GoogleFonts.inter(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }
}
