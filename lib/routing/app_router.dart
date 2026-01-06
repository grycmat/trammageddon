import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/layout/scaffold_with_nav.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/screens/add_incident/add_incident.screen.dart';
import 'package:trammageddon/screens/dashboard/dashboard_screen.dart';
import 'package:trammageddon/screens/hall_of_defame/hall_of_defame_screen.dart';
import 'package:trammageddon/screens/line_details/line_details_screen.dart';
import 'package:trammageddon/screens/login/login.screen.dart';
import 'package:trammageddon/screens/settings/settings_screen.dart';
import 'package:trammageddon/services/auth.service.dart';

final getIt = GetIt.I;

class AppRouter {
  late final authService = getIt.get<AuthService>();
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: authService,
    initialLocation: RouteNames.login,

    redirect: (BuildContext context, GoRouterState state) async {
      final userId = authService.userId;
      final isAnonymous = authService.isAnonymous;
      final isLoginRoute = state.matchedLocation == RouteNames.login;
      final isAuthenticated = userId != null || isAnonymous;

      if (isLoginRoute) {
        return isAuthenticated ? RouteNames.home : RouteNames.login;
      }

      return null;
    },

    routes: [
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNav(routerState: state, child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            name: 'home',
            builder: (context, state) => DashboardScreen(),
          ),

          GoRoute(
            path: RouteNames.hallOfDefame,
            name: 'hall-of-defame',
            builder: (context, state) => const HallOfDefameScreen(),
          ),
          GoRoute(
            path: RouteNames.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.lineDetails,
        name: 'line-details',
        builder: (context, state) => const LineDetailsScreen(lineNumber: '1'),
      ),
      GoRoute(
        path: RouteNames.addIncident,
        name: 'addIncident',
        builder: (context, state) => const AddIncidentScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('BŁĄD')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'STRONA NIE ZNALEZIONA',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error?.toString() ?? 'Nieznany błąd',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
