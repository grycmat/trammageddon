import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trammageddon/services/preferences.service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PreferencesService _preferencesService;
  String? _username;
  String? _userId;
  bool _isAnonymous = false;

  AuthService.init(this._preferencesService) {
    _loadSavedUserData();
  }

  String? get username => _username;

  String? get userId => _userId;

  bool get isAnonymous => _isAnonymous;

  void _loadSavedUserData() {
    _username = _preferencesService.getUsername();
    _userId = _preferencesService.getUserId();
    _isAnonymous = _preferencesService.getIsAnonymous();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _username = credential.user!.email;
      _userId = credential.user!.uid;
      await _preferencesService.saveUsername(_username!);
      await _preferencesService.saveUserId(_userId!);
      notifyListeners();
    }
  }

  Future<void> register(String emailAddress, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    _username = credential.user!.email;
    _userId = credential.user!.uid;
    await _preferencesService.saveUsername(_username!);
    await _preferencesService.saveUserId(_userId!);
    notifyListeners();
  }

  Future<void> loginAnonymously() async {
    _isAnonymous = true;
    _username = null;
    _userId = null;
    await _preferencesService.saveIsAnonymous(true);
    notifyListeners();
  }

  Future<void> logout() async {
    _username = null;
    _userId = null;
    _isAnonymous = false;
    await _preferencesService.clearAll();
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> updateUsername(String username) async {
    await _preferencesService.saveUsername(username);
    _username = username;
    notifyListeners();
  }
}
