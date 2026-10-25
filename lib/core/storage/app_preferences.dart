import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../resources/resources.dart';
import '../session/user_session.dart';

const String _keyLang = 'PREFS_KEY_LANG';
const String _keyIsLoggedIn = 'PREFS_KEY_IS_USER_LOGGED_IN';
const String _keyUserSession = 'PREFS_KEY_USER_SESSION';
const String _keyIsDarkMode = 'IS_DARK_MODE';

/// Stores non-sensitive preferences and user display data.
/// The auth token is stored separately in [SecureTokenStorage].
class AppPreferences {
  final SharedPreferences _prefs;
  AppPreferences(this._prefs);

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

  // ─── User Session (non-sensitive display data) ────────────────────────────

  Future<void> setUserSession(UserSession session) async =>
      _prefs.setString(_keyUserSession, json.encode(session.toJson()));

  Future<UserSession?> getUserSession() async {
    final raw = _prefs.getString(_keyUserSession);
    if (raw == null) return null;
    return UserSession.fromJson(json.decode(raw) as Map<String, dynamic>);
  }

  Future<void> clearUserSession() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserSession);
  }

  // ─── Theme ────────────────────────────────────────────────────────────────

  Future<void> setIsDarkMode(bool isDark) async =>
      _prefs.setBool(_keyIsDarkMode, isDark);

  Future<bool> isDarkMode() async => _prefs.getBool(_keyIsDarkMode) ?? false;
}
