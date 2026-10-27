import '../../../../core/core.dart';
import '../../domain/repository/auth_repository.dart';
import '../auth_api.dart';
import '../model/login_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final AppPreferences _appPreferences;
  final SecureTokenStorage _secureTokenStorage;

  AuthRepositoryImpl(
    this._authApi,
    this._appPreferences,
    this._secureTokenStorage,
  );

  @override
  Future<Result<UserSession>> login(String username, String password) {
    return safeApiCall(() async {
      final computerName = await resolveComputerName();
      // final deviceId = await getDeviceId();
      final langId = await _appPreferences.getLangId();
      final loginResponse = await _authApi.login(LoginRequest(
        username: username,
        password: password,
        computerName: computerName,
        type: "1",
        appKey: "",
        deviceId: '',
        langId: langId
      ));

      if (loginResponse.success != true) {
        throw AuthFailure(
          (langId == "1" ? loginResponse.nameAr : loginResponse.nameEn) ??
              AppStrings.authenticationFailed,
          loginResponse.nameEn == null && loginResponse.nameAr == null,
        );
      }

      if (loginResponse.token != null && loginResponse.token!.isNotEmpty) {
        await _secureTokenStorage.saveToken(loginResponse.token!);
      }

      final session = loginResponse.toDomain();
      await _appPreferences.setUserSession(session);
      await _appPreferences.setUserLoggedIn(true);

      return session;
    });
  }

  @override
  Future<void> logout() async {
    await _secureTokenStorage.deleteToken();
    await _appPreferences.clearUserSession();
    await _appPreferences.setUserLoggedIn(false);
  }
}
