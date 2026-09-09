import 'package:shared_preferences/shared_preferences.dart';

/// Persistent application preferences for MASARI.
///
/// Keeps lightweight user-facing state (language, theme and onboarding)
/// across application restarts without coupling the UI to SharedPreferences.
class AppPersistence {
  AppPersistence._(this._preferences);

  final SharedPreferences _preferences;

  static const _localeKey = 'masari.locale';
  static const _themeModeKey = 'masari.theme_mode';
  static const _onboardingCompletedKey = 'masari.onboarding_completed';

  static Future<AppPersistence> create() async {
    return AppPersistence._(await SharedPreferences.getInstance());
  }

  String get localeCode => _preferences.getString(_localeKey) ?? 'ar';

  Future<bool> setLocaleCode(String value) =>
      _preferences.setString(_localeKey, value);

  String get themeMode => _preferences.getString(_themeModeKey) ?? 'dark';

  Future<bool> setThemeMode(String value) =>
      _preferences.setString(_themeModeKey, value);

  bool get onboardingCompleted =>
      _preferences.getBool(_onboardingCompletedKey) ?? false;

  Future<bool> setOnboardingCompleted(bool value) =>
      _preferences.setBool(_onboardingCompletedKey, value);
}
