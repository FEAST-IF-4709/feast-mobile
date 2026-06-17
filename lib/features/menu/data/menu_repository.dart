import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../shared/utils/url_utils.dart';
import '../domain/menu_item.dart';

part 'menu_repository.g.dart';

/// Provides the [MenuRepository] backed by the shared [Dio] client.
@riverpod
MenuRepository menuRepository(MenuRepositoryRef ref) =>
    MenuRepository(ref.watch(dioProvider));

/// Fetches the outlet menu from the public (unauthenticated) endpoint.
class MenuRepository {
  const MenuRepository(this._dio);

  final Dio _dio;

  /// `GET /api/v1/public/outlets/{outletId}/menu/`
  ///
  /// Public endpoint — skips auth header via [skipAuth] extra.
  /// Returns categories with their items; only items with
  /// [MenuItem.stockAvailable] == true are shown in the menu response.
  Future<List<MenuCategory>> getMenu(String outletId) async {
    try {
      final res = await _dio.get<dynamic>(
        '/api/v1/public/outlets/$outletId/menu/',
        options: Options(extra: {'skipAuth': true}),
      );
      final body = res.data as Map<String, dynamic>;
      final data = body['data'] as Map<String, dynamic>;
      final menu = data['menu'] as List<dynamic>;
      return menu
          .map((e) => MenuCategory.fromJson(_fixImageUrls(e as Map<String, dynamic>)))
          .toList();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Map<String, dynamic> _fixImageUrls(Map<String, dynamic> category) {
    final items = (category['items'] as List<dynamic>? ?? []).map((e) {
      final item = Map<String, dynamic>.from(e as Map<String, dynamic>);
      item['image_url'] = fixMediaUrl(item['image_url'] as String?);
      return item;
    }).toList();
    return {...category, 'items': items};
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
