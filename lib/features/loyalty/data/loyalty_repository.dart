import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/loyalty_account.dart';

part 'loyalty_repository.g.dart';

@riverpod
LoyaltyRepository loyaltyRepository(LoyaltyRepositoryRef ref) =>
    LoyaltyRepository(ref.watch(dioProvider));

/// Data-layer access to the customer loyalty endpoint.
class LoyaltyRepository {
  const LoyaltyRepository(this._dio);

  final Dio _dio;

  /// GET /api/v1/customers/me/loyalty/
  /// Returns balance, tier, tier_points_in_window, and last ~50 transactions.
  Future<LoyaltyAccount> getLoyalty() async {
    try {
      final response =
          await _dio.get<dynamic>('/api/v1/customers/me/loyalty/');
      final body = response.data as Map<String, dynamic>;
      return LoyaltyAccount.fromJson(body['data'] as Map<String, dynamic>);
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
      message: e.message ?? 'Network error.',
      code: 'NETWORK_ERROR',
    );
  }
}
