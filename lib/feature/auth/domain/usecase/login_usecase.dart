import '../../../../core/core.dart';
import '../repository/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;
  const LoginParams({required this.username, required this.password});
}

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<Result<UserSession>> call(LoginParams params) =>
      _repository.login(params.username, params.password);
}
