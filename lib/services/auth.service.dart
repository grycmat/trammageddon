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

  AuthService.init(this._preferencesService);

  Future<void> addUser(User user) async {
    try {
      await _firestore.collection(_collectionName).add(user.toMap());
    } catch (e) {
      throw Exception('Failed to upload user: $e');
    }
  }

  void _loadSavedUsername() {
    _username = _preferencesService.getUsername();
    _userId = _preferencesService.getUserId();
    notifyListeners();
  }

  Future<void> login(String username, password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (username.isNotEmpty) {
      _username = username;
      await _preferencesService.saveUsername(username, password);
      notifyListeners();
    } else {
      throw Exception('Invalid user data');
    }
  }

  Future<void> logout() async {
    _username = null;
    _userId = null;
    await _preferencesService.clearUsername();
    notifyListeners();
  }

  Future<void> updateUsername(String username) async {
    await _preferencesService.saveUsername(username);
    notifyListeners();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
