import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'force_logout_notifier.g.dart';

/// Monotonically incrementing counter; the token-refresh interceptor increments
/// this when an unrecoverable 401 is received (refresh token also invalid).
///
/// [AuthNotifier] watches this to trigger a rebuild that re-checks token
/// storage (which will be empty) and returns [AuthState.unauthenticated].
@Riverpod(keepAlive: true)
class ForceLogoutNotifier extends _$ForceLogoutNotifier {
  @override
  int build() => 0;

  void trigger() => state++;
}
