import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  const City({this.id, required this.index, required this.name});

  final String? id;
  final int index;
  final String name;

  Map<String, dynamic> toMap() {
    return {'index': index, 'name': name};
  }

  factory City.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return City(
      id: doc.id,
      index: data['index'] ?? '',
      name: data['name'] ?? '',
    );
  }
}
