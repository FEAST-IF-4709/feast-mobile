import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

abstract final class _Keys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
}

/// Wraps flutter_secure_storage for JWT token persistence.
///
/// Access and refresh tokens MUST be stored here — never in shared_preferences
/// or plain memory (CLAUDE.md §4.1).
///
/// On Flutter Web, flutter_secure_storage_web uses AES-GCM via the browser's
/// Web Crypto API with no in-memory key cache and no mutex. Concurrent writes
/// each find localStorage empty, each generate a different AES key, and the
/// last one wins — leaving the first token encrypted under a discarded key.
/// All writes here are strictly sequential to prevent that race.
@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService();
}

class SecureStorageService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  /// Returns null if the token is absent or if the Web Crypto layer is in a
  /// broken state (e.g. key mismatch after hot reload with stale JS Promises).
  /// Callers treat null as "no token"; downstream 401 handling takes over.
  Future<String?> getAccessToken() async {
    try {
      return await _storage
          .read(key: _Keys.accessToken)
          .timeout(const Duration(seconds: 8));
    } catch (_) {
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage
          .read(key: _Keys.refreshToken)
          .timeout(const Duration(seconds: 8));
    } catch (_) {
      return null;
    }
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage
        .write(key: _Keys.accessToken, value: accessToken)
        .timeout(const Duration(seconds: 8));
    await _storage
        .write(key: _Keys.refreshToken, value: refreshToken)
        .timeout(const Duration(seconds: 8));
  }

  Future<void> clearTokens() async {
    try {
      await _storage
          .delete(key: _Keys.accessToken)
          .timeout(const Duration(seconds: 5));
      await _storage
          .delete(key: _Keys.refreshToken)
          .timeout(const Duration(seconds: 5));
    } catch (_) {
      // Best-effort — token is already unusable if storage is broken.
    }
  }
}
