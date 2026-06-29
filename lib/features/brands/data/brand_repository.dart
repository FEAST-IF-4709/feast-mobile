import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../shared/utils/url_utils.dart';
import '../domain/brand.dart';

part 'brand_repository.g.dart';

@riverpod
BrandRepository brandRepository(BrandRepositoryRef ref) =>
    BrandRepository(ref.watch(dioProvider));

/// Fetches the list of brands from `GET /api/v1/public/brands/`.
class BrandRepository {
  const BrandRepository(this._dio);

  final Dio _dio;

  Future<List<Brand>> getBrands() async {
    try {
      final res = await _dio.get<dynamic>(
        '/api/v1/public/brands/',
        options: Options(extra: {'skipAuth': true}),
      );
      final body = res.data as Map<String, dynamic>;
      final list = body['data'] as List<dynamic>;
      return list
          .map((e) => Brand.fromJson(_clean(e as Map<String, dynamic>)))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// Normalises a raw brand JSON object before passing it to [Brand.fromJson]:
  /// - Converts empty strings to `null` for nullable string fields.
  /// - Converts the `operating_hours` object → human-readable display string.
  Map<String, dynamic> _clean(Map<String, dynamic> raw) {
    return {
      ...raw,
      'logo_url': fixMediaUrl(_nullIfEmpty(raw['logo_url'])),
      'banner_url': fixMediaUrl(_nullIfEmpty(raw['banner_url'])),
      'phone': _nullIfEmpty(raw['phone']),
      'description': _nullIfEmpty(raw['description']),
      'location_address': _nullIfEmpty(raw['location_address']),
      'operating_hours': _formatHours(raw['operating_hours']),
    };
  }

  String? _nullIfEmpty(dynamic v) {
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }

  /// Converts the operating_hours map into a display string.
  ///
  /// If weekday and weekend slots are identical, returns a single "HH:mm – HH:mm".
  /// Otherwise returns "Weekday HH:mm–HH:mm · Weekend HH:mm–HH:mm".
  String? _formatHours(dynamic raw) {
    if (raw == null || raw is! Map) return null;
    final map = Map<String, dynamic>.from(raw);
    if (map.isEmpty) return null;

    String? slot(String key) {
      final d = map[key];
      if (d is! Map) return null;
      final open = d['open']?.toString();
      final close = d['close']?.toString();
      if (open == null || close == null) return null;
      return '$open – $close';
    }

    final weekday = slot('mon');
    final weekend = slot('sat');

    if (weekday == null && weekend == null) return null;
    if (weekday == weekend || weekend == null) return weekday;
    if (weekday == null) return weekend;
    return 'Weekday $weekday · Weekend $weekend';
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
