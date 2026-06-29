import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/env.dart';
import '../data/profile_dto.dart';
import '../providers/profile_notifier.dart';

/// Edit-profil screen: name + phone editable, email read-only, DOB removed.
/// Photo: image_picker (camera/gallery) → multipart PATCH on save.
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  XFile? _pickedImage;
  Uint8List? _pickedImageBytes;
  bool _isSaving = false;
  Map<String, String>? _fieldErrors;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileNotifierProvider).valueOrNull;
    _nameController = TextEditingController(text: profile?.fullName ?? '');
    _phoneController = TextEditingController(text: profile?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _pickedImage = file;
        _pickedImageBytes = bytes;
      });
    }
  }

  void _showPickerSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined,
                  color: AppColors.primary),
              title: Text('Kamera', style: GoogleFonts.inter()),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined,
                  color: AppColors.primary),
              title: Text('Galeri', style: GoogleFonts.inter()),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    setState(() {
      _isSaving = true;
      _fieldErrors = null;
    });

    try {
      await ref.read(profileNotifierProvider.notifier).updateProfile(
            ProfileUpdateRequest(
              fullName: _nameController.text.trim(),
              phone: _phoneController.text.trim(),
              photoFile: _pickedImage,
            ),
          );
      if (mounted) Navigator.of(context).pop();
    } on ApiException catch (e) {
      setState(() => _fieldErrors = e.fieldErrors);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileNotifierProvider).valueOrNull;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit Profil',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Photo picker
            Center(
              child: GestureDetector(
                onTap: _showPickerSheet,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        _buildAvatar(profile?.profilePhotoUrl),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Ketuk untuk ganti foto',
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Full Name
            _buildField(
              label: 'Nama Lengkap',
              controller: _nameController,
              icon: Icons.person_outline,
              fieldError: _fieldErrors?['full_name'],
            ),
            const SizedBox(height: 20),

            // Email — read-only
            _buildField(
              label: 'Email',
              controller: TextEditingController(text: profile?.email ?? ''),
              icon: Icons.email_outlined,
              readOnly: true,
              hint: 'Email tidak dapat diubah',
            ),
            const SizedBox(height: 20),

            // Phone
            _buildField(
              label: 'Nomor Telepon',
              controller: _phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              fieldError: _fieldErrors?['phone'],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Simpan Perubahan',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String? profilePhotoUrl) {
    const double size = 110;

    Widget child;
    if (_pickedImageBytes != null) {
      child = Image.memory(
        _pickedImageBytes!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            const Icon(Icons.person, size: 50, color: Colors.grey),
      );
    } else {
      final url = _resolveUrl(profilePhotoUrl);
      if (url.isNotEmpty) {
        child = CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, _) => const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, _, _) =>
              const Icon(Icons.person, size: 50, color: Colors.grey),
        );
      } else {
        child = const Icon(Icons.person, size: 50, color: Colors.grey);
      }
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2),
        color: Colors.grey.shade200,
      ),
      child: ClipOval(child: child),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool readOnly = false,
    String? hint,
    TextInputType? keyboardType,
    String? fieldError,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(
            color: readOnly ? Colors.grey.shade500 : Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon,
                color: readOnly ? Colors.grey.shade400 : Colors.grey,
                size: 20),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
            filled: readOnly,
            fillColor: readOnly ? Colors.grey.shade50 : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: fieldError != null
                    ? Colors.red
                    : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: readOnly ? Colors.grey.shade300 : AppColors.primary,
              ),
            ),
            errorText: fieldError,
          ),
        ),
      ],
    );
  }

  String _resolveUrl(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    return '$kApiBaseUrl$raw';
  }
}
