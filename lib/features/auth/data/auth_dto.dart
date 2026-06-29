// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart';

/// POST /api/v1/auth/customer/login/
/// At least one of [phone] or [email] must be non-null (validated client-side).
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    @JsonKey(includeIfNull: false) String? phone,
    @JsonKey(includeIfNull: false) String? email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

/// POST /api/v1/auth/customer/register/
@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String phone,
    @JsonKey(name: 'full_name') required String fullName,
    required String password,
    @JsonKey(includeIfNull: false) String? email,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
