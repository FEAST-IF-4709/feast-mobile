import 'package:image_picker/image_picker.dart';

/// Payload untuk PATCH /api/v1/customers/me/
/// Fields null = tidak dikirim dalam request.
/// Jika [photoFile] tidak null, request dikirim sebagai multipart/form-data.
class ProfileUpdateRequest {
  const ProfileUpdateRequest({
    this.fullName,
    this.phone,
    this.photoFile,
  });

  final String? fullName;
  final String? phone;
  final XFile? photoFile;
}
