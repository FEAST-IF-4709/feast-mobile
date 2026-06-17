import '../../core/constants/env.dart';

/// Rewrites backend-local image URLs so they resolve correctly on any device.
///
/// In local development the backend emits absolute URLs like
/// `http://localhost:8000/media/...`. On an Android emulator `10.0.2.2` is
/// used; on a physical device the machine's LAN IP is needed. This function
/// replaces the `localhost`/`127.0.0.1` origin with whatever host
/// [kApiBaseUrl] was configured with at build time, keeping the rest of the
/// path intact.
String? fixMediaUrl(String? url) {
  if (url == null) return null;
  final base = Uri.parse(kApiBaseUrl);
  final origin = '${base.scheme}://${base.host}:${base.port}';
  return url.replaceFirstMapped(
    RegExp(r'https?://(localhost|127\.0\.0\.1)(:\d+)?'),
    (_) => origin,
  );
}
