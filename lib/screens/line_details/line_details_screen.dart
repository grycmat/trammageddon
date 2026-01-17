import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/screens/line_details/incident_card.dart';
import 'package:trammageddon/screens/line_details/line_details_header.dart';
import 'package:trammageddon/services/incident.service.dart';

var getIt = GetIt.I;

class LineDetailsScreen extends StatelessWidget {
  const LineDetailsScreen({super.key, required this.lineNumber});
  final String lineNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LineDetailsHeader(
        lineNumber: lineNumber,
        onBack: () => context.pop(),
      ),
      body: Expanded(
        child: FutureBuilder(
          future: getIt.get<IncidentService>().getIncidentsForLine(
            line: lineNumber,
          ),
          builder: (context, AsyncSnapshot<List<Incident>> asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting ||
                asyncSnapshot.connectionState == ConnectionState.active) {
              return const Center(child: CircularProgressIndicator());
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
        ),
      ),
    );
  }
}
