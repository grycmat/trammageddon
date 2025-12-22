import 'package:flutter/material.dart';
import 'package:trammageddon/screens/dashboard/all_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/my_all_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/my_today_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/today_incidents_count.dart';
import 'package:trammageddon/screens/dashboard/top_ranking.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'CO TAM W MIEŚCIE',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: TodayIncidentsCount()),
              const SizedBox(width: 16),
              Expanded(child: AllIncidentsCount()),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'ME ŻALE',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: MyTodayIncidentsCount()),
              const SizedBox(width: 16),
              Expanded(child: MyAllIncidentsCount()),
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
          TopRanking(),
        ],
      ),
    );
  }
}
