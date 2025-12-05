import 'package:flutter/material.dart';
import 'package:trammageddon/data/categories.dart';
import 'package:trammageddon/model/category.model.dart';
import 'package:trammageddon/screens/add_incident/category_tag.dart';
import 'package:trammageddon/screens/add_incident/statement_frame.dart';
import 'package:trammageddon/screens/hall_of_defame/detailed_ranking_entry.dart';
import 'package:trammageddon/widgets/new_incident_button.dart';

class HallOfDefameScreen extends StatefulWidget {
  const HallOfDefameScreen({super.key});

  @override
  State<HallOfDefameScreen> createState() => _HallOfDefameScreenState();
}

class _HallOfDefameScreenState extends State<HallOfDefameScreen> {
  final Set<Category> _selectedCategories = {};

  final List<RankingData> _rankings = [
    RankingData(rank: 1, line: '7', incidents: 18),
    RankingData(rank: 2, line: '22', incidents: 15),
    RankingData(rank: 3, line: '9', incidents: 12),
    RankingData(rank: 4, line: '1', incidents: 10),
    RankingData(rank: 5, line: '3', incidents: 8),
  ];

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'TOP 5 NAJWIĘKSZYCH PROBLEMÓW',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 1.5,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ..._rankings.map((data) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: DetailedRankingEntry(
                            rank: data.rank,
                            line: data.line,
                            incidents: data.incidents,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                StatementFrame(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'NAJCZĘSTSZE KATEGORIE:',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: 1.5,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: kCategories.map((category) {
                          return CategoryTag(
                            label: category.label,
                            isSelected: _selectedCategories.contains(category),
                            onTap: () => _toggleCategory(category),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: SafeArea(top: false, child: const NewIncidentButton()),
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
