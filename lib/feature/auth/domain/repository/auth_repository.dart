import '../../../../core/core.dart';

/// Abstract contract for authentication operations.
abstract class AuthRepository {
  /// Authenticates the user and persists session data.
  /// Throws [Failure] subtypes on error.
  Future<UserSession> login(String username, String password);

  /// Clears all session data and logs the user out.
  Future<void> logout();
}
