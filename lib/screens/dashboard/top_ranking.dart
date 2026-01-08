import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/model/ranking_item.model.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/screens/add_incident/statement_frame.dart';
import 'package:trammageddon/screens/dashboard/top_ranking_item.dart';
import 'package:trammageddon/services/incident.service.dart';

var getIt = GetIt.I;

class TopRanking extends StatelessWidget {
  const TopRanking({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.get<IncidentService>().getTopRankings(),
      builder: (_, AsyncSnapshot<List<RankingItem>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          final topRankings = snapshot.data;

          if (topRankings == null) {
            return Container();
          }

          var index = 1;

          return InkWell(
            onTap: () {
              context.push(RouteNames.lineDetails);
            },
            child: StatementFrame(
              child: Column(
                children: [
                  for (var entry in topRankings)
                    Column(
                      children: [
                        TopRankingItem(
                          rank: index++,
                          line: entry.line,
                          reports: entry.incidentsCount,
                        ),
                        if (index == topRankings.length)
                          Container(
                            height: 1,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.3),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          );
        }
        return Center(child: Text('PUSTO...'));
      },
    );
  }
}
