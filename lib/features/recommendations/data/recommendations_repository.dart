import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/popular_item.dart';

part 'recommendations_repository.g.dart';

@riverpod
RecommendationsRepository recommendationsRepository(
        RecommendationsRepositoryRef ref) =>
    RecommendationsRepository(ref.watch(dioProvider));

class RecommendationsRepository {
  const RecommendationsRepository(this._dio);

  final Dio _dio;

  /// `GET /api/v1/recommendations/brands/{brandId}/popular/?outlet_id={outletId}&limit={limit}`
  ///
  /// Returns products ranked by quantity sold in the last [windowDays] days.
  /// Response matches [MenuItem] shape + [PopularItem.totalQtySold].
  Future<List<PopularItem>> getPopular({
    required String brandId,
    required String outletId,
    int limit = 10,
    int windowDays = 30,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        '/api/v1/recommendations/brands/$brandId/popular/',
        queryParameters: {
          'outlet_id': outletId,
          'limit': limit,
          'window_days': windowDays,
        },
        options: Options(extra: {'skipAuth': true}),
      );
      final body = res.data as Map<String, dynamic>;
      final list = body['data'] as List<dynamic>;
      return list
          .map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
          .toList();
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
