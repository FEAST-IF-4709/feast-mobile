import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/order_detail.dart';
import '../domain/order_summary.dart';

part 'order_history_repository.g.dart';

/// Provides the [OrderHistoryRepository] backed by the shared [Dio] instance.
@riverpod
OrderHistoryRepository orderHistoryRepository(OrderHistoryRepositoryRef ref) =>
    OrderHistoryRepository(ref.watch(dioProvider));

/// Data-layer access to customer order history endpoints.
///
/// All methods return parsed domain models or throw [ApiException].
class OrderHistoryRepository {
  const OrderHistoryRepository(this._dio);

  final Dio _dio;

  /// GET /api/v1/me/orders/ — customer's own order history (newest first).
  ///
  /// Response uses CustomerOrderSummarySerializer: includes outlet_name,
  /// brand_name, and item_count directly — no manual computation needed.
  Future<List<OrderSummary>> getOrders() async {
    try {
      final response = await _dio.get<dynamic>('/api/v1/me/orders/');
      final body = response.data as Map<String, dynamic>;
      final list = body['data'] as List<dynamic>;
      return list
          .map((e) => OrderSummary.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// GET /api/v1/orders/{orderId}/ — full detail for one order.
  Future<OrderDetail> getOrderDetail(String orderId) async {
    try {
      final response =
          await _dio.get<dynamic>('/api/v1/orders/$orderId/');
      final body = response.data as Map<String, dynamic>;
      return OrderDetail.fromJson(body['data'] as Map<String, dynamic>);
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
