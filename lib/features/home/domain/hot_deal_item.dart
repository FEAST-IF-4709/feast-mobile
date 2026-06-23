// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hot_deal_item.freezed.dart';
part 'hot_deal_item.g.dart';

@freezed
class HotDealItem with _$HotDealItem {
  const factory HotDealItem({
    @JsonKey(name: 'brand_id') required String brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'original_price') required String originalPrice,
    @JsonKey(name: 'effective_price') required String effectivePrice,
    @JsonKey(name: 'discount_type') required String discountType,
    @JsonKey(name: 'discount_value') required String discountValue,
    @JsonKey(name: 'outlet_id') String? outletId,
  }) = _HotDealItem;

  factory HotDealItem.fromJson(Map<String, dynamic> json) =>
      _$HotDealItemFromJson(json);
}
