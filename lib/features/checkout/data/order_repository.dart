import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../cart/domain/cart_item.dart';
import '../domain/order_result.dart';

part 'order_repository.g.dart';

/// Provides the [OrderRepository] backed by the shared [Dio] client.
@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) =>
    OrderRepository(ref.watch(dioProvider));

/// Submits customer orders via the QR-table flow.
class OrderRepository {
  const OrderRepository(this._dio);

  final Dio _dio;

  /// `POST /api/v1/orders/qr-table/`
  ///
  /// [tableId] is sourced from [QrSessionNotifier] and passed explicitly.
  /// The backend derives outlet/brand from the table record — no need to
  /// send outlet_id or brand_id (CLAUDE.md §3.3).
  Future<OrderResult> createOrder({
    required String tableId,
    required List<CartItem> items,
    String? notes,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        '/api/v1/orders/qr-table/',
        data: {
          'table_id': tableId,
          'payment_method': 'QRIS_MIDTRANS',
          'items': items
              .map(
                (item) => {
                  'outlet_product_id': item.outletProductId,
                  'quantity': item.quantity,
                  if (item.itemNotes != null && item.itemNotes!.isNotEmpty)
                    'item_notes': item.itemNotes,
                },
              )
              .toList(),
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
      );
      final body = res.data as Map<String, dynamic>;
      return OrderResult.fromJson(body['data'] as Map<String, dynamic>);
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
