import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/api/force_logout_notifier.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../cart/providers/cart_notifier.dart';
import '../../loyalty/providers/loyalty_notifier.dart';
import '../../qr_session/providers/qr_session_notifier.dart';
import '../data/auth_dto.dart';
import '../data/auth_repository.dart';
import '../domain/auth_state.dart';
import '../domain/auth_tokens.dart';
import '../domain/customer.dart';

part 'auth_notifier.g.dart';

/// Manages persistent auth state for the entire app.
///
/// Consumers use `.when(data:, loading:, error:)` per CLAUDE.md §2.3.
/// The router guard watches this provider to enforce the unauthenticated → /login redirect.
///
/// On app start, [build] performs a silent token refresh; if refresh fails
/// (token expired/blacklisted) it clears storage and returns [Unauthenticated].
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    // Rebuild whenever the interceptor forces a logout due to hard 401.
    ref.watch(forceLogoutNotifierProvider);

    final storage = ref.read(secureStorageServiceProvider);
    final accessToken = await storage.getAccessToken();
    final refreshToken = await storage.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      return const AuthState.unauthenticated();
    }

    try {
      final repo = ref.read(authRepositoryProvider);
      final tokens = await repo.refreshToken(refreshToken);
      await storage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
      final customer = await repo.fetchCustomerProfile();
      return AuthState.authenticated(tokens: tokens, customer: customer);
    } catch (_) {
      await storage.clearTokens();
      return const AuthState.unauthenticated();
    }
  }

  /// Authenticates with email or phone + password.
  ///
  /// Sets state to [AsyncLoading] during the call, then [AsyncData(Authenticated)]
  /// on success or [AsyncError(ApiException)] on failure.
  Future<void> login(LoginRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loginAndFetch(
          () => ref.read(authRepositoryProvider).login(request),
        ));
  }

  /// Registers a new customer and auto-logs in on success.
  Future<void> register(RegisterRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loginAndFetch(
          () => ref.read(authRepositoryProvider).register(request),
        ));
  }

  /// Clears tokens, QR session, and invalidates auth state. Best-effort server logout.
  Future<void> logout() async {
    final storage = ref.read(secureStorageServiceProvider);
    final refreshToken = await storage.getRefreshToken();

    if (refreshToken != null) {
      try {
        await ref.read(authRepositoryProvider).logout(refreshToken);
      } on ApiException catch (_) {
        // Non-fatal — token is blacklisted client-side regardless.
      }
    }

    await storage.clearTokens();
    // Clear QR session so a new scan is required after re-login (CLAUDE.md §4.3).
    await ref.read(qrSessionNotifierProvider.notifier).clearSession();
    // Clear cart on logout (CLAUDE.md §4.3).
    ref.read(cartNotifierProvider.notifier).clearCart();
    // Invalidate keepAlive loyalty cache so stale balance can't leak to next user.
    ref.invalidate(loyaltyAccountProvider);
    state = const AsyncData(AuthState.unauthenticated());
  }

  Future<AuthState> _loginAndFetch(
    Future<AuthTokens> Function() tokenCall,
  ) async {
    final tokens = await tokenCall();
    final storage = ref.read(secureStorageServiceProvider);
    await storage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    final customer = await ref.read(authRepositoryProvider).fetchCustomerProfile();
    return AuthState.authenticated(tokens: tokens, customer: customer);
  }

  /// Returns the [Customer] if currently authenticated, null otherwise.
  Customer? get currentCustomer =>
      state.valueOrNull?.whenOrNull(authenticated: (_, c) => c);
}
