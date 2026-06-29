import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../domain/voucher_template.dart';

/// Fetches all active voucher templates across every brand.
/// Uses dioProvider directly — same pattern as the working hotDealsProvider.
final voucherCatalogProvider =
    FutureProvider.autoDispose<List<VoucherTemplate>>((ref) async {
  final dio = ref.watch(dioProvider);
  try {
    final response = await dio
        .get<dynamic>('/api/v1/customers/voucher-catalog/')
        .timeout(const Duration(seconds: 12));
    final body = response.data as Map<String, dynamic>;
    final raw = body['data'];
    if (raw == null) return [];
    return (raw as List<dynamic>)
        .map((e) => VoucherTemplate.fromJson(e as Map<String, dynamic>))
        .toList();
  } on DioException catch (e) {
    throw Exception('Network: ${e.message}');
  } catch (e) {
    throw Exception('Parse: $e');
  }
});
