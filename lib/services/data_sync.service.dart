import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trammageddon/model/category.model.dart';
import 'package:trammageddon/model/city.model.dart';
import 'package:trammageddon/model/tram_line.model.dart';
import 'package:trammageddon/services/preferences.service.dart';

class DataSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PreferencesService _preferencesService;

  final String _citiesCollection = 'cities';
  final String _linesCollection = 'lines';
  final String _categoriesCollection = 'categories';

  List<City> _cities = [];
  List<TramLine> _tramLines = [];
  List<Category> _categories = [];

  List<City> get cities => _cities;
  List<TramLine> get tramLines => _tramLines;
  List<Category> get categories => _categories;

  DataSyncService(this._preferencesService);

  DateTime? get lastSyncDate => _preferencesService.getLastDataSync();

  Future<void> downloadData() async {
    await Future.wait([
      downloadCities(),
      downloadTramLines(),
      downloadCategories(),
    ]);
    await _preferencesService.setLastDataSync(DateTime.now());
  }

  Future<List<City>> downloadCities() async {
    final snapshot = await _firestore
        .collection(_citiesCollection)
        .orderBy('index')
        .get();
    _cities = snapshot.docs.map((doc) => City.fromFirestore(doc)).toList();
    return _cities;
  }

  Future<List<TramLine>> downloadTramLines() async {
    final snapshot = await _firestore
        .collection(_linesCollection)
        .orderBy('number')
        .get();
    _tramLines = snapshot.docs.map((doc) => TramLine.fromFirestore(doc)).toList();
    return _tramLines;
  }

  Future<List<Category>> downloadCategories() async {
    final snapshot = await _firestore
        .collection(_categoriesCollection)
        .orderBy('index')
        .get();
    _categories = snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
    return _categories;
  }
}
