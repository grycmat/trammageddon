import 'package:cloud_firestore/cloud_firestore.dart';

class TramLine {
  final String? id;
  final String number;
  final String description;
  final String city;

  const TramLine({
    this.id,
    required this.number,
    required this.description,
    required this.city,
  });

  String get formatted => '$number - $description';

  Map<String, dynamic> toMap() {
    return {'number': number, 'description': description, 'city': city};
  }

  factory TramLine.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TramLine(
      id: doc.id,
      number: data['number'] ?? '',
      description: data['description'] ?? '',
      city: data['city'] ?? '',
    );
  }
}
