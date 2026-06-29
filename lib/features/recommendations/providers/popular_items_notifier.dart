import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../qr_session/providers/qr_session_notifier.dart';
import '../data/recommendations_repository.dart';
import '../domain/popular_item.dart';

part 'popular_items_notifier.g.dart';

/// Fetches the top-selling products for the current outlet session.
///
/// Returns `null` when no QR session is active.
/// Invalidate to refresh: `ref.invalidate(popularItemsNotifierProvider)`.
@riverpod
class PopularItemsNotifier extends _$PopularItemsNotifier {
  @override
  Future<List<PopularItem>?> build() async {
    final session = await ref.watch(qrSessionNotifierProvider.future);
    if (session == null) return null;
    return ref.read(recommendationsRepositoryProvider).getPopular(
          brandId: session.brandId,
          outletId: session.outletId,
        );
  }
}
