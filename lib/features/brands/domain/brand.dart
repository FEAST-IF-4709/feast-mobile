import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';
part 'brand.g.dart';

/// Converts lat/lng that the API sends as numeric strings ("−6.973544")
/// or null into a nullable double.
class _DoubleFromStringConverter implements JsonConverter<double?, Object?> {
  const _DoubleFromStringConverter();

  @override
  double? fromJson(Object? json) {
    if (json == null) return null;
    if (json is double) return json;
    if (json is int) return json.toDouble();
    if (json is String) return double.tryParse(json);
    return null;
  }

  @override
  Object? toJson(double? value) => value;
}

/// A brand as returned by `GET /api/v1/public/brands/`.
///
/// `operating_hours` is pre-formatted to a display string by [BrandRepository]
/// before reaching this model (the raw API value is an object).
///
/// Empty strings from the API are converted to `null` in the repository layer
/// so UI code can rely on `null` checks instead of `.isEmpty` guards.
@freezed
class Brand with _$Brand {
  const factory Brand({
    required String id,
    required String name,
    required String slug,
    String? description,
    @JsonKey(name: 'cuisine_type') String? cuisineType,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'banner_url') String? bannerUrl,
    String? phone,
    @JsonKey(name: 'location_address') String? locationAddress,
    @JsonKey(name: 'operating_hours') String? operatingHours,
    @JsonKey(name: 'is_accepting_orders') @Default(true) bool isAcceptingOrders,
    @JsonKey(name: 'is_busy_mode') @Default(false) bool isBusyMode,
    @_DoubleFromStringConverter() double? latitude,
    @_DoubleFromStringConverter() double? longitude,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}
