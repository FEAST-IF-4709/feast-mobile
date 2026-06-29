// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'featured_banner.freezed.dart';
part 'featured_banner.g.dart';

@freezed
class FeaturedBanner with _$FeaturedBanner {
  const factory FeaturedBanner({
    @JsonKey(name: 'brand_id') required String brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'brand_logo_url') String? brandLogoUrl,
    required String title,
    @Default('') String subtitle,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'target_outlet_id') String? targetOutletId,
  }) = _FeaturedBanner;

  factory FeaturedBanner.fromJson(Map<String, dynamic> json) =>
      _$FeaturedBannerFromJson(json);
}
