import 'package:freezed_annotation/freezed_annotation.dart';

part 'outlet.freezed.dart';
part 'outlet.g.dart';

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

/// A single outlet as returned by `GET /api/v1/outlets/nearby/`.
///
/// Results are pre-sorted nearest-first by the backend.
/// [distanceKm] is computed server-side from the customer's lat/lng.
@freezed
class Outlet with _$Outlet {
  const factory Outlet({
    required String id,
    required String name,
    @JsonKey(name: 'brand_id') String? brandId,
    @JsonKey(name: 'brand_name') String? brandName,
    String? address,
    @_DoubleFromStringConverter() double? latitude,
    @_DoubleFromStringConverter() double? longitude,
    @JsonKey(name: 'distance_km') double? distanceKm,
  }) = _Outlet;

  factory Outlet.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);
}
