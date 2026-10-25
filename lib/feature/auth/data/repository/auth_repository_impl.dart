import 'package:dio/dio.dart';
import '../../../../core/core.dart';
import '../../domain/repository/auth_repository.dart';
import '../auth_api.dart';
import '../model/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final AppPreferences _appPreferences;
  final SecureTokenStorage _secureTokenStorage;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._authApi,
    this._appPreferences,
    this._secureTokenStorage,
    this._networkInfo,
  );

  @override
  Future<UserSession> login(String username, String password) async {
    if (!await _networkInfo.isConnected) {
      throw const NetworkFailure();
    }

    try {
      final response = await _authApi.login(username, password);
      final loginResponse = ModelLoginResponseRemote.fromJson(response);

      if (loginResponse.success == true) {
        // Save token securely
        if (loginResponse.token != null && loginResponse.token!.isNotEmpty) {
          await _secureTokenStorage.saveToken(loginResponse.token!);
        }

        final session = loginResponse.toSession();
        // Save user session in shared preferences
        await _appPreferences.setUserSession(session);
        await _appPreferences.setUserLoggedIn(true);

        return session;
      } else {
        throw AuthFailure(
          loginResponse.nameEn ?? loginResponse.nameAr ?? 'Authentication failed',
        );
      }
    } on DioException catch (e) {
      if (e.error is Failure) {
        throw e.error as Failure;
      }
      throw ServerFailure(e.message ?? 'Server error occurred');
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _secureTokenStorage.deleteToken();
    await _appPreferences.clearUserSession();
    await _appPreferences.setUserLoggedIn(false);
  }
}
