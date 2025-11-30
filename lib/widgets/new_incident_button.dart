import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/widgets/stamped_button.dart';

class NewIncidentButton extends StatelessWidget {
  const NewIncidentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StampedButton(
      onPressed: () => context.push(RouteNames.addIncident),
      icon: Icons.add_alert,
      label: 'ZGŁOŚ NOWE ŻALE',
    );
  }
}
