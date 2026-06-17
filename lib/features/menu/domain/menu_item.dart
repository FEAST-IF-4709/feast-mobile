import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart';

/// A single product available in an outlet's menu.
///
/// API field `id` is the outlet-scoped product ID — exposed as
/// [outletProductId] for clarity across the cart and order layers.
/// [effectivePrice] is a computed getter that applies [activePromotion]
/// when present; use this everywhere a displayable/chargeable price is needed.
@freezed
class MenuItem with _$MenuItem {
  const MenuItem._();

  const factory MenuItem({
    /// Outlet-scoped product ID — maps to API field `id`.
    @JsonKey(name: 'id') required String outletProductId,
    required String name,
    required String price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'stock_available') required bool stockAvailable,
    @JsonKey(name: 'active_promotion') ActivePromotion? activePromotion,
  }) = _MenuItem;

  /// Price after promotion. Returns [price] unchanged when no promotion.
  ///
  /// PERCENT promotion: price × (1 - discountValue / 100)
  /// FIXED promotion:   price − discountValue (clamped to ≥ 0)
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

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
}

/// Active promotion on a menu item. Null when no promotion is running.
@freezed
class ActivePromotion with _$ActivePromotion {
  const factory ActivePromotion({
    @JsonKey(name: 'discount_type') required String discountType,
    @JsonKey(name: 'discount_value') required String discountValue,
  }) = _ActivePromotion;

  factory ActivePromotion.fromJson(Map<String, dynamic> json) =>
      _$ActivePromotionFromJson(json);
}

/// A category grouping of [MenuItem]s from the outlet menu endpoint.
@freezed
class MenuCategory with _$MenuCategory {
  const factory MenuCategory({
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    required List<MenuItem> items,
  }) = _MenuCategory;

  factory MenuCategory.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryFromJson(json);
}
