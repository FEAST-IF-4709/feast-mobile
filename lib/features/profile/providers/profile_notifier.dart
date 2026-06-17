import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_exception.dart';
import '../data/profile_dto.dart';
import '../data/profile_repository.dart';
import '../domain/customer_profile.dart';

part 'profile_notifier.g.dart';

/// Manages the authenticated customer's profile state.
///
/// keepAlive: true — prevents re-fetch on every tab switch.
/// Invalidate via [ref.invalidate(profileNotifierProvider)] after logout or
/// if a fresh fetch is needed.
@Riverpod(keepAlive: true)
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<CustomerProfile> build() =>
      ref.read(profileRepositoryProvider).getProfile();

  /// Patches the profile.
  ///
  /// When [req.photoFile] is non-null, applies an optimistic UI update
  /// (local file path shown immediately) and rolls back on failure.
  Future<void> updateProfile(ProfileUpdateRequest req) async {
    final previous = state;

    // Optimistic: show picked file path locally before upload completes.
    if (req.photoFile != null) {
      state = previous.whenData(
        (p) => p.copyWith(localPhotoPath: req.photoFile!.path),
      );
    }

    try {
      final updated =
          await ref.read(profileRepositoryProvider).updateProfile(req);
      state = AsyncData(updated);
    } on ApiException {
      state = previous; // Rollback on failure.
      rethrow;
    }
  }
}
