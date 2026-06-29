// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_profile.freezed.dart';
part 'customer_profile.g.dart';

/// Domain model for a customer's profile as returned by GET /api/v1/customers/me/
/// and updated via PATCH /api/v1/customers/me/.
///
/// [loyaltyPointsBalance] is null in M7 — populated in M8 from the loyalty endpoint.
/// [localPhotoPath] is transient (not serialised): holds a picked file path during
/// the optimistic photo-update window; cleared when the server responds.
@freezed
class CustomerProfile with _$CustomerProfile {
  const factory CustomerProfile({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    String? email,
    required String phone,
    @JsonKey(name: 'profile_photo') String? profilePhotoUrl,
    // M8: populated from GET /api/v1/customers/me/loyalty/
    int? loyaltyPointsBalance,
    // Transient — never from/to JSON; used for optimistic photo preview only.
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(null)
    String? localPhotoPath,
  }) = _CustomerProfile;

  factory CustomerProfile.fromJson(Map<String, dynamic> json) =>
      _$CustomerProfileFromJson(json);
}
