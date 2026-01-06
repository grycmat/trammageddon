import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/widgets/nav_bar.dart';
import 'package:trammageddon/widgets/new_incident_fab.dart';

class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({
    super.key,
    required this.routerState,
    required this.child,
    appBar,
  });

  final GoRouterState routerState;
  final Widget child;
  final AppBar? appBar = null;
  final skipAppBarRoutes = const [RouteNames.hallOfDefame, RouteNames.settings];

  _shouldShowFab() => !skipAppBarRoutes.contains(routerState.fullPath);

  @override
  Widget build(BuildContext context) {
    print(routerState.fullPath);
    return Scaffold(
      appBar: appBar,
      body: Padding(padding: const EdgeInsets.only(top: 32), child: child),
      bottomNavigationBar: const NavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: NewIncidentFab(show: _shouldShowFab()),
    );
  }
}
