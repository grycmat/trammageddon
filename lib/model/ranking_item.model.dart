import 'package:cloud_firestore/cloud_firestore.dart';

class RankingItem {
  final String line;
  final int incidentsCount;

  RankingItem({required this.line, required this.incidentsCount});

  Map<String, dynamic> toMap() {
    return {'line': line, 'incidentsCount': incidentsCount};
  }

  factory RankingItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RankingItem(
      line: data['line'] ?? '',
      incidentsCount: data['incidentsCount'] ?? 0,
    );
  }
}
