import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/services/incident.service.dart';

class NewIncidentFab extends StatelessWidget {
  const NewIncidentFab({super.key, required this.show});

  final bool show;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      // onPressed: () => context.push(RouteNames.addIncident),
      onPressed: () => GetIt.I.get<IncidentService>().uploadLines(),
      label: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.identity()..rotateZ(-0.05),
        height: show ? 64 : 0,
        width: show ? 380 : 0,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).scaffoldBackgroundColor),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add_alert),
              ),
              Text('ZGŁOŚ NOWE ŻALE'),
            ],
          ),
        ),
      ),
    );
  }
}
