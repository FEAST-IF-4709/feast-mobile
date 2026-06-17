import 'package:freezed_annotation/freezed_annotation.dart';

import '../../menu/domain/menu_item.dart';

part 'popular_item.freezed.dart';
part 'popular_item.g.dart';

/// A product from the popular products endpoint.
///
/// Shares the same JSON shape as [MenuItem] (id = outlet_product_id,
/// name, price, image_url, stock_available, active_promotion) with
/// the addition of [totalQtySold]. Only available when the endpoint
/// is called with an explicit `outlet_id` query parameter.
@freezed
class PopularItem with _$PopularItem {
  const PopularItem._();

  const factory PopularItem({
    @JsonKey(name: 'id') required String outletProductId,
    required String name,
    required String price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'stock_available') required bool stockAvailable,
    @JsonKey(name: 'active_promotion') ActivePromotion? activePromotion,
    @JsonKey(name: 'total_qty_sold') required int totalQtySold,
  }) = _PopularItem;

  String get effectivePrice {
    final base = double.tryParse(price) ?? 0;
    final promo = activePromotion;
    if (promo == null) return price;
    if (promo.discountType == 'PERCENT') {
      final pct = double.tryParse(promo.discountValue) ?? 0;
      return (base * (1 - pct / 100)).toStringAsFixed(2);
    }
    final fixed = double.tryParse(promo.discountValue) ?? 0;
    return (base - fixed).clamp(0.0, double.infinity).toStringAsFixed(2);
  }

  factory PopularItem.fromJson(Map<String, dynamic> json) =>
      _$PopularItemFromJson(json);
}
