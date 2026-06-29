import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../domain/app_notification_entry.dart';
import '../providers/notification_history_notifier.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(notificationHistoryNotifierProvider);
    final unread = entries.where((e) => !e.isRead).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: Colors.black87,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Notifikasi',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black87,
          ),
        ),
        actions: [
          if (unread > 0)
            TextButton(
              onPressed: () =>
                  ref.read(notificationHistoryNotifierProvider.notifier).markAllRead(),
              child: Text(
                'Tandai Semua Dibaca',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: entries.isEmpty
          ? _buildEmpty(context)
          : _buildList(context, ref, entries),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFFDF2E9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 36,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada notifikasi',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Update pesananmu akan muncul di sini.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    WidgetRef ref,
    List<AppNotificationEntry> entries,
  ) {
    final grouped = _groupByDate(entries);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: grouped.length,
      itemBuilder: (context, i) {
        final group = grouped[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                group.label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            ...group.entries.map(
              (entry) => _NotificationTile(entry: entry),
            ),
          ],
        );
      },
    );
  }

  List<_DateGroup> _groupByDate(List<AppNotificationEntry> entries) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<AppNotificationEntry>> map = {};

    for (final e in entries) {
      final d = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      final String label;
      if (!d.isBefore(today)) {
        label = 'Hari Ini';
      } else if (!d.isBefore(yesterday)) {
        label = 'Kemarin';
      } else {
        label =
            '${d.day} ${_monthNames[d.month - 1]} ${d.year}';
      }
      (map[label] ??= []).add(e);
    }

    return map.entries
        .map((e) => _DateGroup(label: e.key, entries: e.value))
        .toList();
  }

  static const _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des',
  ];
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.entry});

  final AppNotificationEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (!entry.isRead) {
          // Mark only this entry read by marking all (simpler, still correct UX)
          ref.read(notificationHistoryNotifierProvider.notifier).markAllRead();
        }
        if (entry.orderId != null) {
          context.push(
            '/order-history/${entry.orderId}',
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: entry.isRead ? Colors.white : const Color(0xFFFDF2E9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: entry.isRead
                ? Colors.transparent
                : const Color(0xFFF1DDD1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: entry.isRead
                    ? Colors.grey.shade100
                    : AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 20,
                color:
                    entry.isRead ? Colors.grey.shade400 : AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: entry.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.body,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _relativeTime(entry.timestamp),
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            if (!entry.isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }
}

class _DateGroup {
  const _DateGroup({required this.label, required this.entries});
  final String label;
  final List<AppNotificationEntry> entries;
}
