import '../../../../core/core.dart';

abstract class AuthRepository {
  Future<Result<UserSession>> login(String username, String password);

  Future<void> logout();
}
