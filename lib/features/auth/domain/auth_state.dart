import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_tokens.dart';
import 'customer.dart';

part 'auth_state.freezed.dart';

/// Sealed union consumed by [AuthNotifier] and the router guard.
///
/// The router watches this to enforce the unauthenticated → /login redirect.
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated({
    required AuthTokens tokens,
    required Customer customer,
  }) = Authenticated;
}
