import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/data/categories.dart';
import 'package:trammageddon/model/category.model.dart';
import 'package:trammageddon/model/ranking_item.model.dart';
import 'package:trammageddon/screens/hall_of_defame/detailed_ranking_entry.dart';
import 'package:trammageddon/services/incident.service.dart';

var getIt = GetIt.I;

class HallOfDefameScreen extends StatefulWidget {
  const HallOfDefameScreen({super.key});

  @override
  State<HallOfDefameScreen> createState() => _HallOfDefameScreenState();
}

class _HallOfDefameScreenState extends State<HallOfDefameScreen> {
  final Set<Category> _selectedCategories = {};

  @override
  void initState() {
    super.initState();
    final defaultCategory = kCategories.firstWhere(
      (c) => c.label == 'BRAK OGRZEWANIA/KLIMATYZACJI',
      orElse: () => kCategories.first,
    );
    _selectedCategories.add(defaultCategory);
  }

  void _toggleCategory(Category category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  Widget _generateList(AsyncSnapshot<List<RankingItem>> snapshot) {
    var data = snapshot.data;
    if (data == null) {
      return Container();
    }

    var rank = 1;
    return Column(
      children: data.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DetailedRankingEntry(
            rank: rank++,
            line: item.line,
            incidents: item.incidentsCount,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: FutureBuilder(
                    future: getIt.get<IncidentService>().getTopRankings(),
                    builder:
                        (
                          BuildContext context,
                          AsyncSnapshot<List<RankingItem>> snapshot,
                        ) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'TOP 10 NAJGORSZYCH Z NAJGORSZYCH',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      letterSpacing: 1.5,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              if (snapshot.connectionState ==
                                  ConnectionState.active)
                                const CircularProgressIndicator(),
                              if (snapshot.hasData)
                                _generateList(snapshot)
                              else
                                Center(child: Text('PUSTO...')),
                            ],
                          );
                        },
                  ),
                ),
                const SizedBox(height: 32),
                // const TopCategories(),
                // const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RankingData {
  final int rank;
  final String line;
  final int incidents;

  RankingData({
    required this.rank,
    required this.line,
    required this.incidents,
  });
}
