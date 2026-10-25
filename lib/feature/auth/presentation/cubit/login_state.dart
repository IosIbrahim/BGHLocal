import '../../../../core/core.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final UserSession session;
  const LoginSuccess(this.session);
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}
