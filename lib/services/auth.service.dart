import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:trammageddon/model/user.model.dart';
import 'package:trammageddon/services/preferences.service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'users';
  final PreferencesService _preferencesService;
  String? _username;
  String? _userId;

  AuthService.init(this._preferencesService) {
    _loadSavedUserData();
  }

  get username => _username;
  get userId => _userId;

  Future<DocumentReference> uploadUser(User user) async {
    try {
      var userdata = await _firestore
          .collection(_collectionName)
          .add(user.toMap());
      print(userdata);
      return userdata;
    } catch (e) {
      throw Exception('Failed to upload user: $e');
    }
  }

  User _createUser(String username, String password) {
    return User(
      username: username,
      passwordHash: _hashPassword(password),
      createdAt: DateTime.now(),
    );
  }

  void _loadSavedUserData() {
    _username = _preferencesService.getUsername();
    _userId = _preferencesService.getUserId();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (username.isNotEmpty && password.isNotEmpty) {
      _username = username;
      await _preferencesService.saveUsername(username);
      notifyListeners();
    } else {
      throw Exception('Invalid login data');
    }
  }

  Future<void> register(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (username.isNotEmpty && password.isNotEmpty) {
      final user = _createUser(username, password);
      final userdata = await uploadUser(user);
      _username = username;
      _userId = userdata.id;
      await _preferencesService.saveUsername(username);
      await _preferencesService.saveUserId(userdata.id);
      notifyListeners();
    } else {
      throw Exception('Invalid register data');
    }
  }

  Future<void> logout() async {
    _username = null;
    _userId = null;
    await _preferencesService.clearAll();
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
