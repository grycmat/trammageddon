import 'package:cloud_firestore/cloud_firestore.dart';

class TramLine {
  final String? id;
  final String number;
  final String description;

  const TramLine({this.id, required this.number, required this.description});

  String get formatted => '$number - $description';

  Map<String, dynamic> toMap() {
    return {'number': number, 'description': description};
  }

  factory TramLine.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TramLine(
      id: doc.id,
      number: data['number'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
