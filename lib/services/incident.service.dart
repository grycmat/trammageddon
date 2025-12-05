import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trammageddon/model/incident.model.dart';

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
}
