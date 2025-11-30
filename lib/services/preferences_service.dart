import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static PreferencesService? _instance;
  static SharedPreferences? _preferences;

  static const String _keyUsername = 'username';
  static const String _keyThemeMode = 'theme_mode';

  PreferencesService._();

  static Future<PreferencesService> getInstance() async {
    _instance ??= PreferencesService._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<void> saveUsername(String username) async {
    await _preferences?.setString(_keyUsername, username);
  }

  String? getUsername() {
    return _preferences?.getString(_keyUsername);
  }

  Future<void> clearUsername() async {
    await _preferences?.remove(_keyUsername);
  }

  Future<void> saveThemeMode(String mode) async {
    await _preferences?.setString(_keyThemeMode, mode);
  }

  String? getThemeMode() {
    return _preferences?.getString(_keyThemeMode);
  }

  Future<void> clearAll() async {
    await _preferences?.clear();
  }
}
