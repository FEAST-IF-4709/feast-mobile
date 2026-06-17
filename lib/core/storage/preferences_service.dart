import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_service.g.dart';

abstract final class _Keys {
  static const lastQrSession = 'last_qr_session';
  static const cartDraft = 'cart_draft';
  static const savedLocationLat = 'saved_location_lat';
  static const savedLocationLng = 'saved_location_lng';
  static const activeOrderId = 'active_order_id';
}

/// Wraps shared_preferences for non-sensitive, non-token data.
///
/// Allowed: cart draft JSON, last QR session cache, UI preferences.
/// Never store access/refresh tokens here — use [SecureStorageService] instead
/// (CLAUDE.md §4.1).
@Riverpod(keepAlive: true)
PreferencesService preferencesService(PreferencesServiceRef ref) {
  return PreferencesService();
}

class PreferencesService {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<String?> getLastQrSession() async =>
      (await _prefs).getString(_Keys.lastQrSession);

  Future<void> saveLastQrSession(String json) async =>
      (await _prefs).setString(_Keys.lastQrSession, json);

  Future<String?> getCartDraft() async =>
      (await _prefs).getString(_Keys.cartDraft);

  Future<void> saveCartDraft(String json) async =>
      (await _prefs).setString(_Keys.cartDraft, json);

  Future<void> clearQrSession() async =>
      (await _prefs).remove(_Keys.lastQrSession);

  Future<String?> getActiveOrderId() async =>
      (await _prefs).getString(_Keys.activeOrderId);

  Future<void> saveActiveOrderId(String orderId) async =>
      (await _prefs).setString(_Keys.activeOrderId, orderId);

  Future<void> clearActiveOrderId() async =>
      (await _prefs).remove(_Keys.activeOrderId);

  /// Called on logout — clears QR session and cart draft (not tokens; those
  /// are cleared by [SecureStorageService.clearTokens]).
  Future<void> clearAll() async => (await _prefs).clear();

  Future<void> saveLocation(double lat, double lng) async {
    final p = await _prefs;
    await p.setDouble(_Keys.savedLocationLat, lat);
    await p.setDouble(_Keys.savedLocationLng, lng);
  }

  /// Returns the last successfully obtained location, or null if none saved.
  Future<(double lat, double lng)?> getSavedLocation() async {
    final p = await _prefs;
    final lat = p.getDouble(_Keys.savedLocationLat);
    final lng = p.getDouble(_Keys.savedLocationLng);
    if (lat == null || lng == null) return null;
    return (lat, lng);
  }
}
