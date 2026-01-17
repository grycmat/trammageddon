import 'package:cloud_firestore/cloud_firestore.dart';

class Incident {
  final String? id;
  final String line;
  final String lineId;
  final String? vehicleNumber;
  final String description;
  final List<String> categories;
  final DateTime timestamp;
  final String username;
  final String userId;
  final String city;
  final int upvotes;

  Incident({
    this.id,
    required this.line,
    required this.lineId,
    this.vehicleNumber,
    required this.description,
    required this.categories,
    required this.timestamp,
    required this.username,
    required this.userId,
    required this.city,
    this.upvotes = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'line': line,
      'lineId': lineId,
      'vehicleNumber': vehicleNumber,
      'description': description,
      'categories': categories,
      'timestamp': Timestamp.fromDate(timestamp),
      'username': username,
      'userId': userId,
      'city': city,
      'upvotes': upvotes,
    };
  }

  factory Incident.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Incident(
      id: doc.id,
      line: data['line'] ?? '',
      lineId: data['lineId'] ?? '',
      vehicleNumber: data['vehicleNumber'] ?? '',
      description: data['description'] ?? '',
      categories: List<String>.from(data['categories'] ?? []),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      username: data['username'] ?? '',
      userId: data['userId'] ?? '',
      city: data['city'] ?? '',
      upvotes: data['upvotes'] ?? 0,
    );
  }
}
