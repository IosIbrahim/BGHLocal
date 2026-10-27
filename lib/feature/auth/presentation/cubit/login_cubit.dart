import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitial());

  Future<void> login(String username, String password) async {
    emit(const LoginLoading());
    final result = await _loginUseCase(
      LoginParams(username: username, password: password),
    );
    
    result.when(
      success: (session) => emit(LoginSuccess(session)),
      error: (failure) => emit(LoginError(failure.message)),
    );
  }
}
