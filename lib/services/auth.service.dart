import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:trammageddon/services/preferences.service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PreferencesService _preferencesService;
  String? _username;
  String? _userId;

  AuthService.init(this._preferencesService) {
    _loadSavedUserData();
  }

  get username => _username;

  get userId => _userId;

  void _loadSavedUserData() {
    _username = _preferencesService.getUsername();
    _userId = _preferencesService.getUserId();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _username = credential.user!.email;
      _userId = credential.user!.uid;
      await _preferencesService.saveUsername(_username!);
      await _preferencesService.saveUserId(_userId!);
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

  Future<void> logout() async {
    _username = null;
    _userId = null;
    await _preferencesService.clearAll();
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> updateUsername(String username) async {
    await _preferencesService.saveUsername(username);
    _username = username;
    notifyListeners();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
