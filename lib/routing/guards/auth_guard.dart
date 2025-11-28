import 'package:flutter/foundation.dart';

/// Simple authentication state manager
/// Replace with actual auth service when implementing real authentication
class AuthGuard extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    // TODO: Replace with actual authentication logic
    await Future.delayed(const Duration(seconds: 1));

    // Validate credentials
    if (username.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    notifyListeners();
  }
}
