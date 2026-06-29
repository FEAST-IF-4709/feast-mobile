import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/auth_tokens.dart';
import '../domain/customer.dart';
import 'auth_dto.dart';

part 'auth_repository.g.dart';

/// Provides the [AuthRepository] singleton backed by the shared [Dio] client.
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(ref.watch(dioProvider));

/// Data-layer access to all authentication and customer-profile endpoints.
///
/// Every method either returns a parsed domain model or throws [ApiException].
/// Raw [DioException] never escapes this class.
class AuthRepository {
  const AuthRepository(this._dio);

  final Dio _dio;

  /// POST /api/v1/auth/customer/login/
  Future<AuthTokens> login(LoginRequest request) =>
      _postTokens('/api/v1/auth/customer/login/', request.toJson());

  /// POST /api/v1/auth/customer/register/
  Future<AuthTokens> register(RegisterRequest request) =>
      _postTokens('/api/v1/auth/customer/register/', request.toJson());

  /// POST /api/v1/auth/token/refresh/
  Future<AuthTokens> refreshToken(String refreshToken) =>
      _postTokens('/api/v1/auth/token/refresh/', {'refresh': refreshToken});

  /// POST /api/v1/auth/logout/
  /// Best-effort — callers should not fail the logout flow if this throws.
  Future<void> logout(String refreshToken) async {
    try {
      await _dio.post<dynamic>(
        '/api/v1/auth/logout/',
        data: {'refresh': refreshToken},
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// GET /api/v1/customers/me/
  Future<Customer> fetchCustomerProfile() async {
    try {
      final response = await _dio.get<dynamic>('/api/v1/customers/me/');
      final body = response.data as Map<String, dynamic>;
      return Customer.fromJson(body['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<AuthTokens> _postTokens(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post<dynamic>(path, data: data);
      final body = response.data as Map<String, dynamic>;
      return AuthTokens.fromJson(body['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final response = e.response;
    if (response != null && response.data is Map<String, dynamic>) {
      return ApiException.fromResponse(
        response.statusCode ?? 0,
        response.data as Map<String, dynamic>,
      );
    }
    return ApiException(
      statusCode: response?.statusCode ?? 0,
      message: e.message ?? 'Network error. Check your connection.',
      code: 'NETWORK_ERROR',
    );
  }
}
