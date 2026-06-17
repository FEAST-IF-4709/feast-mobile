import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/spacing.dart';
import '../../core/theme/app_theme.dart';
import '../providers/in_app_notification_provider.dart';

/// Full-screen transparent overlay that renders an animated banner whenever
/// [InAppNotificationNotifier] holds a non-null [AppNotification].
///
/// Mount this as a sibling on top of the app's Navigator via
/// [MaterialApp.router]'s `builder` parameter so it appears above all routes.
class NotificationOverlay extends ConsumerStatefulWidget {
  const NotificationOverlay({super.key});

  @override
  ConsumerState<NotificationOverlay> createState() =>
      _NotificationOverlayState();
}

class _NotificationOverlayState extends ConsumerState<NotificationOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  AppNotification? _visible;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() => _visible = null);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppNotification?>(
      inAppNotificationNotifierProvider,
      (prev, next) {
        if (next != null) {
          setState(() => _visible = next);
          _ctrl.forward(from: 0);
        } else {
          _ctrl.reverse();
        }
      },
    );

    if (_visible == null) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.topCenter,
      child: SlideTransition(
        position: _slide,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.md,
              vertical: Spacing.sm,
            ),
            child: _NotificationBanner(
              notification: _visible!,
              onDismiss: () =>
                  ref.read(inAppNotificationNotifierProvider.notifier).dismiss(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationBanner extends StatelessWidget {
  const _NotificationBanner({
    required this.notification,
    required this.onDismiss,
  });

  final AppNotification notification;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onDismiss,
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
          onDismiss();
        }
      },
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md,
            vertical: Spacing.sm + 2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BrandIcon(
                logoUrl: notification.brandLogoUrl,
                brandName: notification.brandName,
              ),
              const SizedBox(width: Spacing.sm + 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.brandName ?? 'FEAST',
                            style: tt.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: Spacing.xs),
                        Text(
                          _relativeTime(notification.shownAt),
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      notification.title,
                      style: tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: FeastColors.textDark,
                      ),
                    ),
                    Text(
                      notification.body,
                      style: tt.bodySmall?.copyWith(
                        color: FeastColors.textDark.withValues(alpha: 0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  String _relativeTime(DateTime shownAt) {
    final diff = DateTime.now().difference(shownAt);
    if (diff.inSeconds < 60) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} mnt lalu';
    return '${diff.inHours} jam lalu';
  }
}

/// Rounded square showing the brand's logo image, or a letter avatar fallback.
class _BrandIcon extends StatelessWidget {
  const _BrandIcon({this.logoUrl, this.brandName});

  final String? logoUrl;
  final String? brandName;

  @override
  Widget build(BuildContext context) {
    const size = 44.0;
    const radius = BorderRadius.all(Radius.circular(10));

    if (logoUrl != null && logoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
          imageUrl: logoUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorWidget: (_, _, _) => _LetterAvatar(
            letter: _initial,
            size: size,
          ),
        ),
      );
    }

    return _LetterAvatar(letter: _initial, size: size);
  }

  String get _initial =>
      (brandName?.isNotEmpty == true) ? brandName![0].toUpperCase() : 'F';
}

class _LetterAvatar extends StatelessWidget {
  const _LetterAvatar({required this.letter, required this.size});

  final String letter;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: FeastColors.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
