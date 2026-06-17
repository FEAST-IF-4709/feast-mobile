import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/qris_payment.dart';

part 'payment_repository.g.dart';

/// Provides the [PaymentRepository] backed by the shared [Dio] client.
@riverpod
PaymentRepository paymentRepository(PaymentRepositoryRef ref) =>
    PaymentRepository(ref.watch(dioProvider));

/// Handles QRIS payment initiation via the feast-backend (never Midtrans directly).
class PaymentRepository {
  const PaymentRepository(this._dio);

  final Dio _dio;

  /// `POST /api/v1/payments/initiate-qris/`
  ///
  /// Idempotent: if a valid unexpired QR already exists for [orderId],
  /// the backend returns the same one. On expiry, calling this again
  /// creates a new Midtrans transaction (with `-r2`/`-r3` suffix internally).
  /// The UI must never call a separate "regenerate" endpoint — always re-call
  /// this method (CLAUDE.md §8.3).
  Future<QrisPayment> initiateQris(String orderId) async {
    try {
      final res = await _dio.post<dynamic>(
        '/api/v1/payments/initiate-qris/',
        data: {'order_id': orderId},
      );
      final body = res.data as Map<String, dynamic>;
      return QrisPayment.fromJson(body['data'] as Map<String, dynamic>);
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
