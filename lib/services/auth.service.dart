import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trammageddon/model/user.model.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  Future<void> addUser(User user) async {
    try {
      await _firestore.collection(_collection).add(user.toMap());
    } catch (e) {
      throw Exception('Failed to upload user: $e');
    }
  }
}
