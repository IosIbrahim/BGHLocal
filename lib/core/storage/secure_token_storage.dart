import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores the auth token encrypted using OS Keystore (Android) / Keychain (iOS).
/// Must be used for ALL sensitive session data instead of SharedPreferences.
class SecureTokenStorage {
  static const _tokenKey = 'auth_token';

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
}
