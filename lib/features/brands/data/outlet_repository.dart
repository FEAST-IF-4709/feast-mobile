import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/outlet.dart';

part 'outlet_repository.g.dart';

@riverpod
OutletRepository outletRepository(OutletRepositoryRef ref) =>
    OutletRepository(ref.watch(dioProvider));

/// Fetches outlets from `GET /api/v1/outlets/nearby/`.
///
/// This is a public endpoint (AllowAny) — no auth token required.
/// Results are pre-sorted nearest-first by the backend.
class OutletRepository {
  const OutletRepository(this._dio);

  final Dio _dio;

  /// `GET /api/v1/outlets/nearby/` — requires customer coordinates.
  ///
  /// Returns outlets sorted nearest-first by the backend.
  /// Only call this when location is available.
  Future<List<Outlet>> getNearbyOutlets({
    required double lat,
    required double lng,
    required String brandId,
    int radiusKm = 25,
    int limit = 50,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        '/api/v1/outlets/nearby/',
        queryParameters: {
          'lat': lat,
          'lng': lng,
          'brand_id': brandId,
          'radius_km': radiusKm,
          'limit': limit,
        },
      );
      final body = res.data as Map<String, dynamic>;
      final list = body['data'] as List<dynamic>;
      return list
          .map((e) => Outlet.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// `GET /api/v1/outlets/nearby/` — all brands, no brand filter.
  ///
  /// Returns outlets across all brands sorted nearest-first.
  /// Used to derive the nearest outlet per brand for the brand list screen.
  Future<List<Outlet>> getNearbyAllOutlets({
    required double lat,
    required double lng,
    int radiusKm = 25,
    int limit = 200,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        '/api/v1/outlets/nearby/',
        queryParameters: {
          'lat': lat,
          'lng': lng,
          'radius_km': radiusKm,
          'limit': limit,
        },
      );
      final body = res.data as Map<String, dynamic>;
      final list = body['data'] as List<dynamic>;
      return list
          .map((e) => Outlet.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// `GET /api/v1/public/outlets/` — no location needed.
  ///
  /// Returns all outlets for [brandId], sorted alphabetically by name.
  /// Use this as fallback when location permission is denied or GPS is off.
  Future<List<Outlet>> getAllOutlets({required String brandId}) async {
    try {
      final res = await _dio.get<dynamic>(
        '/api/v1/public/outlets/',
        queryParameters: {'brand_id': brandId},
        options: Options(extra: {'skipAuth': true}),
      );
      final body = res.data as Map<String, dynamic>;
      final list = body['data'] as List<dynamic>;
      return list
          .map((e) => Outlet.fromJson(e as Map<String, dynamic>))
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
