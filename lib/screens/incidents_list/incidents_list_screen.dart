import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/screens/line_details/incident_card.dart';
import 'package:trammageddon/services/incident.service.dart';
import 'package:trammageddon/widgets/app_progress_indicator.dart';

var getIt = GetIt.I;

class IncidentsListScreen extends StatelessWidget {
  const IncidentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.get<IncidentService>().getLastIncidents(),
      builder: (context, AsyncSnapshot<List<Incident>> asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting ||
            asyncSnapshot.connectionState == ConnectionState.active) {
          return const AppProgressIndicator();
        }
        if (asyncSnapshot.hasData) {
          final incidents = asyncSnapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: incidents.length,
            itemBuilder: (context, index) {
              final item = incidents[index];
              return IncidentCard(
                incident: item,
                upvotes: 0,
                hasVoted: false,
                onUpvote: () => {},
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
