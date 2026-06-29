import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/table_session.dart';

part 'qr_session_repository.g.dart';

/// Provides the [QrSessionRepository] backed by the shared [Dio] client.
@riverpod
QrSessionRepository qrSessionRepository(QrSessionRepositoryRef ref) =>
    QrSessionRepository(ref.watch(dioProvider));

/// Data-layer access to the public QR table-resolve endpoint.
///
/// [resolveToken] intentionally skips the auth interceptor (`skipAuth: true`)
/// because `GET /api/v1/public/tables/resolve/` is unauthenticated.
/// All other repo methods in downstream features (menu, cart, orders) must
/// accept [outletId]/[brandId]/[tableId] as explicit parameters sourced from
/// [QrSessionNotifier] — never via a global header (CLAUDE.md §3.3).
class QrSessionRepository {
  const QrSessionRepository(this._dio);

  final Dio _dio;

  /// `GET /api/v1/public/tables/resolve/?token={qrToken}`
  ///
  /// Public endpoint — auth header deliberately omitted via `skipAuth` extra.
  /// Returns a fully populated [TableSession] with [TableSession.resolvedAt]
  /// set to the current timestamp (client-side field, not from the API).
  ///
  /// [qrToken] may be a raw token string or a full QR URL of the form
  /// `https://app.feast.id/t/{token}` — the token is extracted automatically.
  Future<TableSession> resolveToken(String qrToken) async {
    try {
      final res = await _dio.get<dynamic>(
        '/api/v1/public/tables/resolve/',
        queryParameters: {'token': _extractToken(qrToken)},
        options: Options(extra: {'skipAuth': true}),
      );
      final body = res.data as Map<String, dynamic>;
      final data = body['data'] as Map<String, dynamic>;
      final outlet = data['outlet'] as Map<String, dynamic>;
      final table = data['table'] as Map<String, dynamic>;
      return TableSession.fromJson({
        'outlet_id': outlet['id'] as String,
        'outlet_name': outlet['name'] as String,
        'brand_id': outlet['brand_id'] as String,
        'brand_name': outlet['brand_name'] as String,
        'table_id': table['id'] as String,
        'table_label': table['label'] as String,
        'resolved_at': DateTime.now().toIso8601String(),
      });
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// Extracts the token from a QR URL (`https://app.feast.id/t/{token}`)
  /// or returns [raw] unchanged if it is already a plain token string.
  String _extractToken(String raw) {
    try {
      final uri = Uri.parse(raw);
      final segments = uri.pathSegments;
      // Match path pattern /t/{token}
      final tIndex = segments.indexOf('t');
      if (tIndex != -1 && tIndex + 1 < segments.length) {
        return segments[tIndex + 1];
      }
    } catch (_) {}
    return raw;
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
