import 'package:cloud_firestore/cloud_firestore.dart';

class Incident {
  final String? id;
  final String line;
  final String? vehicleNumber;
  final String description;
  final List<String> categories;
  final DateTime timestamp;
  final String username;
  final String userId;
  final String city;

  Incident({
    this.id,
    required this.line,
    this.vehicleNumber,
    required this.description,
    required this.categories,
    required this.timestamp,
    required this.username,
    required this.userId,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'line': line,
      'vehicleNumber': vehicleNumber,
      'description': description,
      'categories': categories,
      'timestamp': Timestamp.fromDate(timestamp),
      'username': username,
      'userId': userId,
      'city': city,
    };
  }

  factory Incident.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Incident(
      id: doc.id,
      line: data['line'] ?? '',
      vehicleNumber: data['vehicleNumber'] ?? '',
      description: data['description'] ?? '',
      categories: List<String>.from(data['categories'] ?? []),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      username: data['username'] ?? '',
      userId: data['userId'] ?? '',
      city: data['city'] ?? '',
    );
  }
}
