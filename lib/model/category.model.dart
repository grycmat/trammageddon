import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String? id;
  final int index;
  final String label;
  int incidentsCount;

  Category({
    this.id,
    required this.index,
    required this.label,
    this.incidentsCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {'index': index, 'label': label, 'incidentsCount': incidentsCount};
  }

  factory Category.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Category(
      id: doc.id,
      index: data['index'] ?? 0,
      label: data['label'] ?? '',
      incidentsCount: data['incidentsCount'] ?? 0,
    );
  }
}
