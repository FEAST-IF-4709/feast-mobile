/// Typed exception thrown by all repository methods on API failure.
///
/// UI layers catch [ApiException] — never raw [DioException].
/// Field errors follow the backend's `errors: [{field, detail}]` envelope shape.
class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.message,
    this.code = 'ERROR',
    this.fieldErrors,
  });

  final int statusCode;
  final String message;
  final String code;

  /// Keyed by field name; each value is the first error message for that field.
  final Map<String, String>? fieldErrors;

  @override
  String toString() => 'ApiException($statusCode/$code): $message';

  factory ApiException.fromResponse(int statusCode, Map<String, dynamic> body) {
    final code = body['code'] as String? ?? 'ERROR';
    final message = body['message'] as String? ?? 'An error occurred.';

    Map<String, String>? fieldErrors;
    final errors = body['errors'];
    if (errors is List && errors.isNotEmpty) {
      final map = <String, String>{};
      for (final e in errors) {
        if (e is Map) {
          final field = e['field'] as String?;
          final detail = e['detail'] as String? ?? '';
          if (field != null && field.isNotEmpty) {
            map.putIfAbsent(field, () => detail);
          }
        }
      }
      if (map.isNotEmpty) fieldErrors = map;
    }

    return ApiException(
      statusCode: statusCode,
      message: message,
      code: code,
      fieldErrors: fieldErrors,
    );
  }
}
