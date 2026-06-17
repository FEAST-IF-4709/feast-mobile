import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/env.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/token_refresh_interceptor.dart';

part 'api_client.g.dart';

/// Single dio instance for the entire app.
///
/// Interceptor order per CLAUDE.md §3:
///   1. [AuthInterceptor]          — attaches Bearer token
///   2. [TokenRefreshInterceptor]  — handles 401 → refresh → retry; else logout
///   3. [LogInterceptor]           — debug builds only
///
/// No global tenant interceptor: outlet/brand/table IDs are passed explicitly
/// per repository call (CLAUDE.md §3.3).
@riverpod
Dio dio(DioRef ref) {
  final client = Dio(
    BaseOptions(
      baseUrl: kApiBaseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: const {'Content-Type': 'application/json'},
    ),
  );

  client.interceptors.addAll([
    AuthInterceptor(ref),
    TokenRefreshInterceptor(ref),
    if (kDebugMode)
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (o) => debugPrint(o.toString()),
      ),
  ]);

  return client;
}
