// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

/// Domain model for the authenticated customer's profile.
/// Populated from GET /api/v1/customers/me/ after login/register.
@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String phone,
    String? email,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'profile_photo') String? profilePhotoUrl,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
