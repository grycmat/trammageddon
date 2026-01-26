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

      _username = credential.user!.displayName;
      _userId = credential.user!.uid;
      await _preferencesService.saveUsername(_username!);
      await _preferencesService.saveUserId(_userId!);
      notifyListeners();
    }
  }

  Future<void> register(
    String emailAddress,
    String password,
    String displayName,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    await _firebaseAuth.currentUser!.updateDisplayName(displayName);

    _username = displayName;
    _userId = credential.user!.uid;
    await _preferencesService.saveUsername(_username!);
    await _preferencesService.saveUserId(_userId!);
    notifyListeners();
  }

  Future<void> loginAnonymously() async {
    final credentials = await _firebaseAuth.signInAnonymously();
    _userId = credentials.user!.uid;

    _isAnonymous = true;
    _username = 'ANONIM';
    await _preferencesService.saveIsAnonymous(true);
    await _preferencesService.saveUsername(_username!);
    await _preferencesService.saveUserId(_userId!);
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
    if (_updateUsernameLocked(username)) {
      return;
    }

    await _firebaseAuth.currentUser!.updateDisplayName(username);
    await _preferencesService.saveUsername(username);
    _username = username;
    notifyListeners();
  }

  bool _updateUsernameLocked(String username) =>
      username.isEmpty ||
      username == _username ||
      _isAnonymous ||
      _firebaseAuth.currentUser == null;
}
