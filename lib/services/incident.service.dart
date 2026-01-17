import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/data/tram_lines.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/model/ranking_item.model.dart';
import 'package:trammageddon/services/auth.service.dart';

final getIt = GetIt.I;

class IncidentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _incidents = 'incidents';
  final String _incidentsByLine = 'incidents_by_line';
  final String _topCategories = 'top_categories';
  final int _incidentsByLineLimit = 100;

  Future<void> addIncident(Incident incident) async {
    try {
      final batch = _firestore.batch();

      final incidentRef = _firestore.collection(_incidents).doc();
      batch.set(incidentRef, incident.toMap());

      final lineRef = _firestore
          .collection(_incidentsByLine)
          .doc(incident.lineId);
      batch.set(lineRef, {
        'lineId': incident.lineId,
        'line': incident.line,
        'incidentsCount': FieldValue.increment(1),
      }, SetOptions(merge: true));

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to upload incident: $e');
    }
  }

  Future<int?> getAllIncidentsCount() async {
    try {
      return await _firestore
          .collection(_incidents)
          .count()
          .get()
          .then((res) => res.count);
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<List<Incident>> getAllIncidents() async {
    try {
      return await _firestore
          .collection(_incidents)
          .get()
          .then(
            (response) => response.docs
                .map((doc) => Incident.fromFirestore(doc))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<int?> getMyIncidentsCount() async {
    final userId = getIt.get<AuthService>().userId;
    if (userId == null || userId.isEmpty) {
      return 0;
    }
    try {
      return await _firestore
          .collection(_incidents)
          .where('userId', isEqualTo: userId)
          .count()
          .get()
          .then((res) => res.count);
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<int?>? getTodayIncidentsCount() async {
    try {
      return await _firestore
          .collection(_incidents)
          .where('timestamp', isEqualTo: Timestamp.fromDate(DateTime.now()))
          .count()
          .get()
          .then((res) => res.count);
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<List<Incident>> getMyIncidents() async {
    final userId = getIt.get<AuthService>().userId;
    if (userId == null || userId.isEmpty) {
      return [];
    }
    try {
      return _firestore
          .collection(_incidents)
          .where('userId', isEqualTo: userId)
          .get()
          .then(
            (response) => response.docs
                .map((doc) => Incident.fromFirestore(doc))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<int?> getMyTodayIncidentsCount() async {
    final userId = getIt.get<AuthService>().userId;
    if (userId == null || userId.isEmpty) {
      return 0;
    }
    try {
      return _firestore
          .collection(_incidents)
          .where('userId', isEqualTo: userId)
          .where('timestamp', isEqualTo: Timestamp.fromDate(DateTime.now()))
          .count()
          .get()
          .then((res) => res.count);
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<List<RankingItem>> getTopRankings({int limit = 5}) async {
    try {
      return await _firestore
          .collection(_incidentsByLine)
          .orderBy('incidentsCount', descending: true)
          .limit(limit)
          .get()
          .then(
            (res) => res.docs
                .map((doc) => (RankingItem.fromFirestore(doc)))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to fetch incidents by line: $e');
    }
  }

  Future<List<Incident>> getIncidentsForLine({
    required String line,
    int limit = 100,
  }) async {
    try {
      return await _firestore
          .collection(_incidents)
          .where('line', isEqualTo: line)
          .limit(limit)
          .get()
          .then(
            (response) => response.docs
                .map((doc) => Incident.fromFirestore(doc))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to fetch incidents by line: $e');
    }
  }

  Future<List<Incident>> getLastIncidents({int limit = 10}) async {
    try {
      return await _firestore
          .collection(_incidents)
          .limit(limit)
          .orderBy('timestamp', descending: true)
          .get()
          .then(
            (response) => response.docs
                .map((doc) => Incident.fromFirestore(doc))
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<void> uploadLines() async {
    final lines = kTramLines;
    final batch = _firestore.batch();

    final linesRef = _firestore.collection('lines');
    for (final line in lines) {
      linesRef.add(line.toMap());
    }

    await batch.commit();
  }
}
