import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../resources/resources.dart';
import '../session/user_session.dart';
import 'secure_token_storage.dart';

const String _keyLang = 'PREFS_KEY_LANG';
const String _keyIsLoggedIn = 'PREFS_KEY_IS_USER_LOGGED_IN';
const String _keyUserSession = 'PREFS_KEY_USER_SESSION';
const String _keyIsDarkMode = 'IS_DARK_MODE';

/// Stores non-sensitive preferences. The user session (which carries ids such
/// as userId/hospId/empId) and the auth token are kept in [SecureTokenStorage].
class AppPreferences {
  final SharedPreferences _prefs;
  final SecureTokenStorage _secure;
  AppPreferences(this._prefs, this._secure);

  // ─── Language ─────────────────────────────────────────────────────────────

  Future<String> getAppLanguage() async {
    final lang = _prefs.getString(_keyLang);
    return lang == LanguageType.ARABIC.getValue()
        ? LanguageType.ARABIC.getValue()
        : LanguageType.ENGLISH.getValue();
  }

  Future<void> changeAppLanguage(String lang) async =>
      _prefs.setString(_keyLang, lang);

  Future<String> getLangId() async {
    final lang = _prefs.getString(_keyLang);
    return lang == LanguageType.ARABIC.getValue() ? '1' : '2';
  }

  Future<Locale> getLocale() async {
    final lang = await getAppLanguage();
    return lang == LanguageType.ARABIC.getValue() ? ARABIC_LOCALE : ENGLISH_LOCALE;
  }

  // ─── Auth State ───────────────────────────────────────────────────────────

  Future<void> setUserLoggedIn(bool isLoggedIn) async =>
      _prefs.setBool(_keyIsLoggedIn, isLoggedIn);

  Future<bool> isUserLoggedIn() async =>
      _prefs.getBool(_keyIsLoggedIn) ?? false;

  // ─── User Session (stored encrypted in SecureTokenStorage) ─────────────────

  Future<void> setUserSession(UserSession session) =>
      _secure.saveSession(json.encode(session.toJson()));

  Future<UserSession?> getUserSession() async {
    var raw = await _secure.getSession();

    // One-time migration: move any legacy plaintext session out of
    // SharedPreferences into secure storage so existing users aren't logged out.
    if (raw == null) {
      final legacy = _prefs.getString(_keyUserSession);
      if (legacy != null) {
        await _secure.saveSession(legacy);
        await _prefs.remove(_keyUserSession);
        raw = legacy;
      }
    }

    if (raw == null) return null;
    return UserSession.fromJson(json.decode(raw) as Map<String, dynamic>);
  }

  Future<void> clearUserSession() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserSession);
    await _secure.deleteSession();
  }

  // ─── Theme ────────────────────────────────────────────────────────────────

  Future<void> setIsDarkMode(bool isDark) async =>
      _prefs.setBool(_keyIsDarkMode, isDark);

  Future<bool> isDarkMode() async => _prefs.getBool(_keyIsDarkMode) ?? false;
}
