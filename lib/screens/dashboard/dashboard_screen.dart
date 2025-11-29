import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/model/ranking.model.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/screens/add_incident/statement_frame.dart';
import 'package:trammageddon/screens/dashboard/data_box.dart';
import 'package:trammageddon/screens/dashboard/top_ranking_item.dart';
import 'package:trammageddon/widgets/stamped_button.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<Ranking> _topRankings = [
    Ranking(rank: 1, line: '7', reports: 28),
    Ranking(rank: 2, line: '14', reports: 22),
    Ranking(rank: 3, line: '23', reports: 19),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'DZIŚ W MIEŚCIE',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DataBox(value: '78', label: 'OKROPIEŃSTW'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DataBox(value: '12', label: 'AKTYWNYCH STREF'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'GORZKIE ŻALE',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DataBox(value: '3', label: 'ZGŁOSZENIA DZIŚ'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DataBox(value: '142', label: 'SUMA ZGŁOSZEŃ'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'NAJGORSI Z NAJGORSZYCH',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          StatementFrame(
            child: Column(
              children: _topRankings.asMap().entries.map((entry) {
                final isLast = entry.key == _topRankings.length - 1;
                return Column(
                  children: [
                    TopRankingItem(
                      rank: entry.value.rank,
                      line: entry.value.line,
                      reports: entry.value.reports,
                    ),
                    if (!isLast)
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.3),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          StampedButton(
            onPressed: () => context.push(RouteNames.addIncident),
            icon: Icons.add_alert,
            label: 'ZGŁOŚ NOWE ŻALE',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
