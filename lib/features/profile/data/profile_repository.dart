import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../domain/customer_profile.dart';
import 'profile_dto.dart';

part 'profile_repository.g.dart';

/// Provides the [ProfileRepository] backed by the shared [Dio] instance.
@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) =>
    ProfileRepository(ref.watch(dioProvider));

/// Data-layer access to the customer profile endpoints.
///
/// All methods return parsed domain models or throw [ApiException].
class ProfileRepository {
  const ProfileRepository(this._dio);

  final Dio _dio;

  /// GET /api/v1/customers/me/
  Future<CustomerProfile> getProfile() async {
    try {
      final response = await _dio.get<dynamic>('/api/v1/customers/me/');
      final body = response.data as Map<String, dynamic>;
      return CustomerProfile.fromJson(body['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// PATCH /api/v1/customers/me/
  /// Uses multipart/form-data when [req.photoFile] is present, otherwise JSON.
  Future<CustomerProfile> updateProfile(ProfileUpdateRequest req) async {
    try {
      final Response<dynamic> response;

      if (req.photoFile != null) {
        final formData = FormData.fromMap({
          if (req.fullName != null) 'full_name': req.fullName,
          if (req.phone != null) 'phone': req.phone,
          'profile_photo': MultipartFile.fromBytes(
            await req.photoFile!.readAsBytes(),
            filename: req.photoFile!.name,
          ),
        });
        response = await _dio.patch<dynamic>(
          '/api/v1/customers/me/',
          data: formData,
        );
      } else {
        final body = <String, dynamic>{};
        if (req.fullName != null) body['full_name'] = req.fullName;
        if (req.phone != null) body['phone'] = req.phone;
        response = await _dio.patch<dynamic>(
          '/api/v1/customers/me/',
          data: body,
        );
      }

      final resBody = response.data as Map<String, dynamic>;
      return CustomerProfile.fromJson(resBody['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final response = e.response;
    if (response != null && response.data is Map<String, dynamic>) {
      return ApiException.fromResponse(
        response.statusCode ?? 0,
        response.data as Map<String, dynamic>,
      );
    }
    return ApiException(
      statusCode: response?.statusCode ?? 0,
      message: e.message ?? 'Network error. Check your connection.',
      code: 'NETWORK_ERROR',
    );
  }
}
