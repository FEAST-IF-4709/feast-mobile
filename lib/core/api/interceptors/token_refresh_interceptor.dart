import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/env.dart';
import '../force_logout_notifier.dart';
import '../../storage/secure_storage_service.dart';

/// Handles 401 responses per CLAUDE.md §3.2:
///   - On 401: attempt a single token refresh using a bare Dio (no interceptors)
///   - If refresh succeeds: save new tokens and retry the original request
///   - If refresh fails: clear storage, trigger [ForceLogoutNotifier] so
///     [AuthNotifier] rebuilds and returns [Unauthenticated]
class TokenRefreshInterceptor extends Interceptor {
  final Ref _ref;
  bool _isRefreshing = false;

  TokenRefreshInterceptor(this._ref);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401 || _isRefreshing) {
      handler.next(err);
      return;
    }

    final storage = _ref.read(secureStorageServiceProvider);
    final storedRefresh = await storage.getRefreshToken();

    if (storedRefresh == null) {
      await _forceLogout(storage);
      handler.next(err);
      return;
    }

    _isRefreshing = true;
    try {
      // Bare Dio — no interceptors — to prevent recursive 401 handling.
      final bare = Dio(
        BaseOptions(
          baseUrl: kApiBaseUrl,
          headers: const {'Content-Type': 'application/json'},
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

      final res = await bare.post<dynamic>(
        '/api/v1/auth/token/refresh/',
        data: {'refresh': storedRefresh},
      );

      final body = res.data as Map<String, dynamic>;
      final data = body['data'] as Map<String, dynamic>;
      final newAccess = data['access'] as String;
      final newRefresh = data['refresh'] as String;

      await storage.saveTokens(
        accessToken: newAccess,
        refreshToken: newRefresh,
      );

      // Retry original request with refreshed access token.
      // Use a fresh bare Dio to avoid re-entering this interceptor.
      final retryDio = Dio(BaseOptions(baseUrl: kApiBaseUrl));
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $newAccess';
      final retry = await retryDio.fetch<dynamic>(opts);
      handler.resolve(retry);
    } on DioException catch (_) {
      await _forceLogout(storage);
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _forceLogout(SecureStorageService storage) async {
    await storage.clearTokens();
    _ref.read(forceLogoutNotifierProvider.notifier).trigger();
  }
}
