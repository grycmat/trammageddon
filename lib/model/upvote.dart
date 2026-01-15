import 'package:cloud_firestore/cloud_firestore.dart';

class Upvote {
  final String userId;
  final String incidentId;

  Upvote({required this.userId, required this.incidentId});

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'incidentId': incidentId};
  }

  factory Upvote.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Upvote(
      userId: data['userId'] ?? '',
      incidentId: data['incidentId'] ?? '',
    );
  }
}
