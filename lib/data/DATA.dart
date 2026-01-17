import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/model/incident_by_line.dart';

const String kSeedUserId = 'seed-user-001';
const String kSeedUsername = 'trammageddon_tester@test.pl';
const String kSeedCity = 'KRAKOW';

final List<Incident> kSeedIncidents = [
  Incident(
    line: '1',
    lineId: 'line_1',
    vehicleNumber: 'RK 2145',
    description: 'TRAMWAJ WYGLADA JAK PO WOJNIE. SIEDZENIA BRUDNE, PODLOGA LEPKA.',
    categories: ['BRUD I SMROD', 'WSZYSTKO NAJGORZEJ'],
    timestamp: DateTime(2025, 1, 15, 8, 30),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 12,
  ),
  Incident(
    line: '1',
    lineId: 'line_1',
    vehicleNumber: 'RK 2150',
    description: 'MOTORNICZA JECHALA JAK SZALONA. LUDZIE SIE PRZEWRACALI.',
    categories: ['SZALONA JAZDA', 'NIEBEZPIECZNA JAZDA'],
    timestamp: DateTime(2025, 1, 14, 17, 45),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 8,
  ),
  Incident(
    line: '3',
    lineId: 'line_3',
    vehicleNumber: 'RK 3201',
    description: 'TLOK NIESAMOWITY. NIE DALO SIE WEJSC.',
    categories: ['TLOK', 'OCZYWISCIE SPOZNIENIE'],
    timestamp: DateTime(2025, 1, 15, 7, 15),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 25,
  ),
  Incident(
    line: '4',
    lineId: 'line_4',
    description: 'KLIMATYZACJA NIE DZIALA. W SRODKU SAUNA.',
    categories: ['UKROP', 'BRAK OGRZEWANIA/KLIMATYZACJI'],
    timestamp: DateTime(2025, 1, 13, 14, 20),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 15,
  ),
  Incident(
    line: '4',
    lineId: 'line_4',
    vehicleNumber: 'RK 4022',
    description: 'PIJANY PASAZER KRZYCZAL NA WSZYSTKICH. NIKT NIC NIE ROBIL.',
    categories: ['AGRESYWNY PASAZER', 'WSZYSTKO NAJGORZEJ'],
    timestamp: DateTime(2025, 1, 12, 22, 30),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 31,
  ),
  Incident(
    line: '5',
    lineId: 'line_5',
    vehicleNumber: 'RK 5018',
    description: 'TRAMWAJ SPOZNIONY 20 MINUT. ZADNYCH INFORMACJI.',
    categories: ['OCZYWISCIE SPOZNIENIE'],
    timestamp: DateTime(2025, 1, 15, 6, 45),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 7,
  ),
  Incident(
    line: '8',
    lineId: 'line_8',
    description: 'ZIMNO JAK W LODOWCE. LUDZIE MARZLI.',
    categories: ['ZIMNICA', 'BRAK OGRZEWANIA/KLIMATYZACJI'],
    timestamp: DateTime(2025, 1, 10, 7, 30),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 19,
  ),
  Incident(
    line: '10',
    lineId: 'line_10',
    vehicleNumber: 'RK 1088',
    description: 'SMROD NIEMOZLIWY. KTOS ZOSTAWIL JEDZENIE.',
    categories: ['BRUD I SMROD'],
    timestamp: DateTime(2025, 1, 14, 12, 0),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 4,
  ),
  Incident(
    line: '13',
    lineId: 'line_13',
    vehicleNumber: 'RK 1355',
    description: 'DRZWI SIE NIE OTWIERALY. MUSIALEM JECHAC DO NASTEPNEGO.',
    categories: ['WSZYSTKO NAJGORZEJ', 'NIE LUBIE GO PO PROSTU'],
    timestamp: DateTime(2025, 1, 11, 16, 20),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 11,
  ),
  Incident(
    line: '14',
    lineId: 'line_14',
    description: 'MOTORNICZY ROZMAWIAL PRZEZ TELEFON CALA DROGE.',
    categories: ['NIEBEZPIECZNA JAZDA', 'SZALONA JAZDA'],
    timestamp: DateTime(2025, 1, 9, 18, 45),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 22,
  ),
  Incident(
    line: '17',
    lineId: 'line_17',
    vehicleNumber: 'RK 1722',
    description: 'TRAMWAJ ZEPSUTY. STALISMY 15 MINUT.',
    categories: ['OCZYWISCIE SPOZNIENIE', 'WSZYSTKO NAJGORZEJ'],
    timestamp: DateTime(2025, 1, 8, 9, 10),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 6,
  ),
  Incident(
    line: '18',
    lineId: 'line_18',
    description: 'TLOK TAK DUZY ZE NIE MOGLEM ODDYCHAC.',
    categories: ['TLOK', 'AGRESYWNY PASAZER'],
    timestamp: DateTime(2025, 1, 15, 8, 0),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 17,
  ),
  Incident(
    line: '20',
    lineId: 'line_20',
    vehicleNumber: 'RK 2044',
    description: 'SIEDZENIA MOKRE. CHYBA KTO WYLAL NAPOJ.',
    categories: ['BRUD I SMROD'],
    timestamp: DateTime(2025, 1, 7, 11, 30),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 3,
  ),
  Incident(
    line: '22',
    lineId: 'line_22',
    description: 'OKNA WYBITE. WIALO.',
    categories: ['ZIMNICA', 'WSZYSTKO NAJGORZEJ'],
    timestamp: DateTime(2025, 1, 6, 20, 15),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 14,
  ),
  Incident(
    line: '24',
    lineId: 'line_24',
    vehicleNumber: 'RK 2411',
    description: 'ZATRZYMAL SIE NA SRODKU TORU. EWAKUACJA.',
    categories: ['WSZYSTKO NAJGORZEJ', 'NIEBEZPIECZNA JAZDA'],
    timestamp: DateTime(2025, 1, 5, 15, 40),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 28,
  ),
  Incident(
    line: '50',
    lineId: 'line_50',
    description: 'NAJGORSZY TRAMWAJ JAKI WIDZIALEM.',
    categories: ['NIE LUBIE GO PO PROSTU', 'WSZYSTKO NAJGORZEJ'],
    timestamp: DateTime(2025, 1, 4, 13, 0),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 9,
  ),
  Incident(
    line: '52',
    lineId: 'line_52',
    vehicleNumber: 'RK 5233',
    description: 'UPAŁ NIE DO ZNIESIENIA. LUDZIE MDLELI.',
    categories: ['UKROP', 'BRAK OGRZEWANIA/KLIMATYZACJI', 'AGRESYWNY PASAZER'],
    timestamp: DateTime(2025, 1, 3, 14, 30),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 20,
  ),
  Incident(
    line: '69',
    lineId: 'line_69',
    description: 'NUMER LINII FAJNY ALE TRAMWAJ NIE.',
    categories: ['NIE LUBIE GO PO PROSTU'],
    timestamp: DateTime(2025, 1, 2, 10, 0),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 42,
  ),
  Incident(
    line: '72',
    lineId: 'line_72',
    vehicleNumber: 'RK 7201',
    description: 'TRAMWAJ JEDZIE. TO WSZYSTKO.',
    categories: ['OCZYWISCIE SPOZNIENIE', 'BRUD I SMROD'],
    timestamp: DateTime(2025, 1, 1, 9, 0),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 5,
  ),
  Incident(
    line: '75',
    lineId: 'line_75',
    description: 'SPOZNIENIE 30 MINUT. REKORD.',
    categories: ['OCZYWISCIE SPOZNIENIE', 'WSZYSTKO NAJGORZEJ'],
    timestamp: DateTime(2024, 12, 31, 23, 30),
    username: kSeedUsername,
    userId: kSeedUserId,
    city: kSeedCity,
    upvotes: 33,
  ),
];

final List<IncidentByLine> kSeedIncidentsByLine = [
  IncidentByLine(lineId: 'line_1', line: '1', incidentsCount: 2),
  IncidentByLine(lineId: 'line_3', line: '3', incidentsCount: 1),
  IncidentByLine(lineId: 'line_4', line: '4', incidentsCount: 2),
  IncidentByLine(lineId: 'line_5', line: '5', incidentsCount: 1),
  IncidentByLine(lineId: 'line_8', line: '8', incidentsCount: 1),
  IncidentByLine(lineId: 'line_10', line: '10', incidentsCount: 1),
  IncidentByLine(lineId: 'line_13', line: '13', incidentsCount: 1),
  IncidentByLine(lineId: 'line_14', line: '14', incidentsCount: 1),
  IncidentByLine(lineId: 'line_17', line: '17', incidentsCount: 1),
  IncidentByLine(lineId: 'line_18', line: '18', incidentsCount: 1),
  IncidentByLine(lineId: 'line_20', line: '20', incidentsCount: 1),
  IncidentByLine(lineId: 'line_22', line: '22', incidentsCount: 1),
  IncidentByLine(lineId: 'line_24', line: '24', incidentsCount: 1),
  IncidentByLine(lineId: 'line_50', line: '50', incidentsCount: 1),
  IncidentByLine(lineId: 'line_52', line: '52', incidentsCount: 1),
  IncidentByLine(lineId: 'line_69', line: '69', incidentsCount: 1),
  IncidentByLine(lineId: 'line_72', line: '72', incidentsCount: 1),
  IncidentByLine(lineId: 'line_75', line: '75', incidentsCount: 1),
];

final Map<String, int> kSeedTopCategories = {
  'WSZYSTKO NAJGORZEJ': 8,
  'OCZYWISCIE SPOZNIENIE': 5,
  'BRUD I SMROD': 4,
  'NIEBEZPIECZNA JAZDA': 3,
  'NIE LUBIE GO PO PROSTU': 3,
  'SZALONA JAZDA': 3,
  'BRAK OGRZEWANIA/KLIMATYZACJI': 3,
  'UKROP': 2,
  'ZIMNICA': 2,
  'AGRESYWNY PASAZER': 3,
  'TLOK': 2,
};

class SeedDataUploader {
  final FirebaseFirestore _firestore;

  SeedDataUploader({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> uploadAllSeedData({
    bool clearExisting = false,
  }) async {
    if (clearExisting) {
      await _clearCollections();
    }

    await uploadIncidents();
    await uploadIncidentsByLine();
    await uploadTopCategories();
  }

  Future<void> _clearCollections() async {
    await _deleteCollection('incidents');
    await _deleteCollection('incidents_by_line');
    await _deleteCollection('top_categories');
  }

  Future<void> _deleteCollection(String collectionPath) async {
    final batch = _firestore.batch();
    final snapshots = await _firestore.collection(collectionPath).get();

    for (final doc in snapshots.docs) {
      batch.delete(doc.reference);
    }

    if (snapshots.docs.isNotEmpty) {
      await batch.commit();
    }
  }

  Future<void> uploadIncidents() async {
    final batch = _firestore.batch();
    final collection = _firestore.collection('incidents');

    for (final incident in kSeedIncidents) {
      final docRef = collection.doc();
      batch.set(docRef, incident.toMap());
    }

    await batch.commit();
  }

  Future<void> uploadIncidentsByLine() async {
    final batch = _firestore.batch();
    final collection = _firestore.collection('incidents_by_line');

    for (final incidentByLine in kSeedIncidentsByLine) {
      final docRef = collection.doc(incidentByLine.lineId);
      batch.set(docRef, incidentByLine.toMap());
    }

    await batch.commit();
  }

  Future<void> uploadTopCategories() async {
    final batch = _firestore.batch();
    final collection = _firestore.collection('top_categories');

    for (final entry in kSeedTopCategories.entries) {
      final docRef = collection.doc(_categoryToDocId(entry.key));
      batch.set(docRef, {
        'category': entry.key,
        'count': entry.value,
      });
    }

    await batch.commit();
  }

  String _categoryToDocId(String category) {
    return category
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('/', '_')
        .replaceAll(RegExp(r'[^a-z0-9_]'), '');
  }
}
