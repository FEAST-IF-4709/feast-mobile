import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/voucher_template.dart';

/// Plain provider — no @riverpod annotation so no build_runner needed.
final voucherRepositoryProvider = Provider.autoDispose<VoucherRepository>((ref) {
  return VoucherRepository(ref.watch(dioProvider));
});

/// Data-layer access to the voucher catalog and customer voucher endpoints.
class VoucherRepository {
  const VoucherRepository(this._dio);

  final Dio _dio;

  /// GET /api/v1/customers/voucher-catalog/ — all active voucher templates across brands.
  Future<List<VoucherTemplate>> getCatalog() async {
    try {
      final response =
          await _dio.get<dynamic>('/api/v1/customers/voucher-catalog/');
      final body = response.data as Map<String, dynamic>;
      final raw = body['data'];
      if (raw == null) return [];
      final list = raw as List<dynamic>;
      return list
          .map((e) => VoucherTemplate.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    } catch (e) {
      // Re-throw any parsing error as a plain exception so the FutureProvider
      // surfaces it in the error state rather than crashing silently.
      throw Exception('Catalog parse error: $e');
    }
  }

  /// POST /api/v1/customers/me/vouchers/redeem/ — exchange points for a voucher.
  Future<void> redeem(String templateId) async {
    try {
      await _dio.post<dynamic>(
        '/api/v1/customers/me/vouchers/redeem/',
        data: {'voucher_template_id': templateId},
      );
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
