import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String username;
  final String passwordHash;
  final DateTime createdAt;

  User({
    this.id,
    required this.username,
    required this.passwordHash,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'passwordHash': passwordHash,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      username: data['username'],
      passwordHash: data['passwordHash'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
