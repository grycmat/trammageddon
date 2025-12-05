import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String username;

  User({this.id, required this.username});

  Map<String, dynamic> toMap() {
    return {'username': username};
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(id: doc.id, username: data['username'] ?? '');
  }
}
