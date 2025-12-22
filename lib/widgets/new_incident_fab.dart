import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/routing/route_names.dart';

class NewIncidentFab extends StatelessWidget {
  const NewIncidentFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      onPressed: () => context.push(RouteNames.addIncident),
      label: AnimatedContainer(
        duration: Duration(seconds: 1),
        transform: Matrix4.identity()..rotateZ(-0.05),
        height: 64,
        width: 300,
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
