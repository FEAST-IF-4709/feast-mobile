import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../storage/secure_storage_service.dart';

/// Attaches `Authorization: Bearer {access_token}` to every outgoing request.
/// If no token is stored (e.g. pre-login), the request proceeds unauthenticated.
class AuthInterceptor extends Interceptor {
  final Ref _ref;

  AuthInterceptor(this._ref);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Public endpoints (e.g. /api/v1/public/tables/resolve/) set this to skip
    // token attachment entirely, even when the user is authenticated.
    if (options.extra['skipAuth'] == true) {
      handler.next(options);
      return;
    }
    // getAccessToken() returns null on timeout/error rather than throwing,
    // so a broken storage state cannot hang the entire request pipeline.
    final token =
        await _ref.read(secureStorageServiceProvider).getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
