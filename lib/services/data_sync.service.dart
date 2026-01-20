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
    // TODO: Implement city download from Firestore
    return [];
  }

  Future<List<TramLine>> downloadTramLines() async {
    // TODO: Implement tram lines download from Firestore
    return [];
  }

  Future<List<Category>> downloadCategories() async {
    // TODO: Implement categories download from Firestore
    return [];
  }
}
