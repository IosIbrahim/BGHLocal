import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../storage/app_preferences.dart';
import '../../storage/secure_token_storage.dart';
import '../../routes/route_manager.dart';

class SessionInterceptor extends QueuedInterceptor {
  final AppPreferences _appPreferences;
  final SecureTokenStorage _tokenStorage;

  SessionInterceptor(this._appPreferences, this._tokenStorage);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _handleSessionExpired();
    }
    handler.next(err);
  }

  Future<void> _handleSessionExpired() async {
    // Clear session data
    await _tokenStorage.deleteToken();
    await _appPreferences.clearUserSession();
    await _appPreferences.setUserLoggedIn(false);

    // Navigate to login screen globally
    final context = RouteGenerator.navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.loginRoute,
        (route) => false,
      );
    }
  }
}
