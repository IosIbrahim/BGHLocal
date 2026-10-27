import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  static const _tokenKey = 'auth_token';
  static const _sessionKey = 'user_session';

  final FlutterSecureStorage _storage;

  SecureTokenStorage() : _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<void> deleteToken() => _storage.delete(key: _tokenKey);

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ─── User session (JSON-encoded UserSession) ───────────────────────────────

  Future<void> saveSession(String sessionJson) =>
      _storage.write(key: _sessionKey, value: sessionJson);

  Future<String?> getSession() => _storage.read(key: _sessionKey);

  Future<void> deleteSession() => _storage.delete(key: _sessionKey);
}
