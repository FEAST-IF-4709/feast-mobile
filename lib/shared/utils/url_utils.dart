import '../../core/constants/env.dart';

/// Rewrites backend image URLs so they resolve correctly on any device.
///
/// Handles two cases:
/// - Absolute URLs with `localhost`/`127.0.0.1` origin are rewritten to use
///   the [kApiBaseUrl] host (needed on Android devices / emulators).
/// - Relative paths (starting with `/`) are prepended with the [kApiBaseUrl]
///   origin (produced by Django's default ImageField serialization).
String? fixMediaUrl(String? url) {
  if (url == null || url.isEmpty) return null;
  final base = Uri.parse(kApiBaseUrl);
  final origin = '${base.scheme}://${base.host}:${base.port}';

  // Relative path: /media/... → http://<host>:<port>/media/...
  if (url.startsWith('/')) return '$origin$url';

  // Absolute localhost URL → replace origin
  return url.replaceFirstMapped(
    RegExp(r'https?://(localhost|127\.0\.0\.1)(:\d+)?'),
    (_) => origin,
  );
}
