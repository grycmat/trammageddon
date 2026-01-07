import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService._(this._preferences);

  final SharedPreferences _preferences;

  static Future<PreferencesService> init() async {
    final preferences = await SharedPreferences.getInstance();
    return PreferencesService._(preferences);
  }

  final String _keyUsername = 'username';
  final String _keyThemeMode = 'theme_mode';
  final String _keyUserId = 'user_id';
  final String _keyIsAnonymous = 'is_anonymous';

  Future<void> saveUsername(String username) async {
    await _preferences.setString(_keyUsername, username);
  }

  Future<void> saveUserId(String userId) async {
    await _preferences.setString(_keyUserId, userId);
  }

  String? getUsername() {
    return _preferences.getString(_keyUsername);
  }

  String? getUserId() {
    return _preferences.getString(_keyUserId);
  }

  Future<void> saveIsAnonymous(bool value) async {
    await _preferences.setBool(_keyIsAnonymous, value);
  }

  bool getIsAnonymous() {
    return _preferences.getBool(_keyIsAnonymous) ?? false;
  }

  Future<void> clearUsername() async {
    await _preferences.remove(_keyUsername);
  }

  Future<void> saveThemeMode(String mode) async {
    await _preferences.setString(_keyThemeMode, mode);
  }

  String? getThemeMode() {
    return _preferences.getString(_keyThemeMode);
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }
}
