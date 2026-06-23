import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../domain/featured_banner.dart';

part 'featured_banner_repository.g.dart';

/// Fetches active featured banners from the public (no-auth) endpoint.
@riverpod
Future<List<FeaturedBanner>> featuredBanners(FeaturedBannersRef ref) async {
  final dio = ref.watch(dioProvider);
  final res = await dio.get<dynamic>('/api/v1/public/featured-banners/');
  final body = res.data as Map<String, dynamic>;
  final raw = (body['data'] ?? body['results'] ?? body) as List<dynamic>;
  return raw
      .map((e) => FeaturedBanner.fromJson(e as Map<String, dynamic>))
      .toList();
}
