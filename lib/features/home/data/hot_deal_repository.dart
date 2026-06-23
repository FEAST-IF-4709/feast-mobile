import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../domain/hot_deal_item.dart';

/// Plain FutureProvider — no @riverpod annotation, no build_runner needed.
final hotDealsProvider =
    FutureProvider.autoDispose<List<HotDealItem>>((ref) async {
  final dio = ref.watch(dioProvider);
  final res = await dio.get<dynamic>('/api/v1/public/hot-deals/');
  final body = res.data as Map<String, dynamic>;
  final raw = body['data'] as List<dynamic>;
  return raw
      .map((e) => HotDealItem.fromJson(e as Map<String, dynamic>))
      .toList();
});
