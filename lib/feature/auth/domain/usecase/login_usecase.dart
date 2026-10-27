import '../../../../core/core.dart';
import '../repository/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;
  const LoginParams({required this.username, required this.password});
}

/// Single-responsibility use case: orchestrates the login operation.
class LoginUseCase extends UseCase<UserSession, LoginParams> {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  @override
  Future<UserSession> call(LoginParams params) =>
      _repository.login(params.username, params.password);
}
