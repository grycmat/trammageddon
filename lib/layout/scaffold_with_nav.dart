import 'package:flutter/material.dart';
import 'package:trammageddon/widgets/nav_bar.dart';
import 'package:trammageddon/widgets/new_incident_fab.dart';

class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({super.key, required this.child, appBar});

  final Widget child;
  final AppBar? appBar = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(padding: const EdgeInsets.only(top: 32), child: child),
      bottomNavigationBar: const NavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const NewIncidentFab(),
    );
  }
}
