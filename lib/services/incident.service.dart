import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/services/auth.service.dart';

var getIt = GetIt.I;

class IncidentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'incidents';

  Future<void> addIncident(Incident incident) async {
    try {
      await _firestore.collection(_collection).add(incident.toMap());
    } catch (e) {
      throw Exception('Failed to upload incident: $e');
    }
  }

  Future<int?> getAllIncidentsCount() async {
    try {
      return await _firestore
          .collection(_collection)
          .count()
          .get()
          .then((res) => res.count);
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllIncidents() async {
    try {
      return await _firestore.collection(_collection).get();
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<int?> getMyIncidentsCount() async {
    try {
      return await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: getIt.get<AuthService>().userId)
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
          .collection(_collection)
          .where('date', isEqualTo: DateTime.now().toString())
          .count()
          .get()
          .then((res) => res.count);
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<Future<QuerySnapshot<Map<String, dynamic>>>> getMyIncidents() async {
    try {
      return _firestore
          .collection(_collection)
          .where('userId', isEqualTo: getIt.get<AuthService>().userId)
          .get();
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }

  Future<int?> getMyTodayIncidentsCount() async {
    try {
      return _firestore
          .collection(_collection)
          .where('userId', isEqualTo: getIt.get<AuthService>().userId)
          .count()
          .get()
          .then((res) => res.count);
    } catch (e) {
      throw Exception('Failed to fetch incidents: $e');
    }
  }
}
