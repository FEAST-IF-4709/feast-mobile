import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/brand_repository.dart';
import '../domain/brand.dart';

part 'brand_notifier.g.dart';

/// Fetches and holds the full list of brands.
///
/// This is a public endpoint — no QR session required.
/// Invalidate to trigger a refresh:
/// ```dart
/// ref.invalidate(brandNotifierProvider);
/// ```
@riverpod
class BrandNotifier extends _$BrandNotifier {
  @override
  Future<List<Brand>> build() async {
    return ref.read(brandRepositoryProvider).getBrands();
  }
}
