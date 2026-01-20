import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentByLine {
  final String lineId;
  final String line;
  final int incidentsCount;

  IncidentByLine({
    required this.lineId,
    required this.line,
    required this.incidentsCount,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["lineId"] = lineId;
    map["line"] = line;
    map["incidentsCount"] = incidentsCount;

    return map;
  }

  factory IncidentByLine.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return IncidentByLine(
      lineId: data["lineId"] ??= "",
      line: data["line"] ??= "",
      incidentsCount: data["incidentsCount"] ??= 0,
    );
  }
}
