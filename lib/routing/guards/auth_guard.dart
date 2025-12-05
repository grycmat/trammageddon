import 'package:flutter/foundation.dart';
import 'package:trammageddon/services/preferences.service.dart';

class AuthGuard extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  final PreferencesService _preferencesService;

  AuthGuard(this._preferencesService) {
    _loadSavedUsername();
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;

  void _loadSavedUsername() {
    _username = _preferencesService.getUsername();
    if (_username != null && _username!.isNotEmpty) {
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  Future<void> login(String username) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Small delay for UX

    if (username.isNotEmpty) {
      _isAuthenticated = true;
      _username = username;
      await _preferencesService.saveUsername(username);
      notifyListeners();
    } else {
      throw Exception('Invalid username');
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _username = null;
    await _preferencesService.clearUsername();
    notifyListeners();
  }

  Future<void> updateUsername(String username) async {
    _username = username;
    await _preferencesService.saveUsername(username);
    notifyListeners();
  }
}
