import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/routing/guards/auth_guard.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/screens/add_incident/add_incident.screen.dart';
import 'package:trammageddon/screens/dashboard/dashboard_screen.dart';
import 'package:trammageddon/screens/hall_of_defame/hall_of_shame_screen.dart';
import 'package:trammageddon/screens/login/login.screen.dart';

class AppRouter {
  final AuthGuard authGuard;

  AppRouter({required this.authGuard});

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: authGuard,
    initialLocation: RouteNames.home,

    redirect: (BuildContext context, GoRouterState state) async {
      final isAuthenticated = authGuard.isAuthenticated;
      final isLoginRoute = state.matchedLocation == RouteNames.login;

      // If not authenticated and trying to access protected route
      // if (!isAuthenticated && !isLoginRoute) {
      //   return RouteNames.login;
      // }

      // If authenticated and on login screen, redirect to home
      // TODO: Uncomment when home screen is created
      // if (isAuthenticated && isLoginRoute) {
      //   return RouteNames.home;
      // }

      // No redirect needed
      return null;
    },

    routes: [
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        pageBuilder: (context, state) => _buildBrutalistPageTransition(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.addIncident,
        name: 'addIncident',
        pageBuilder: (context, state) => _buildBrutalistPageTransition(
          context: context,
          state: state,
          child: const AddIncidentScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.home,
        name: 'home',
        pageBuilder: (context, state) => _buildBrutalistPageTransition(
          context: context,
          state: state,
          child: DashboardScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.hallOfDefame,
        name: 'hall-of-defame',
        pageBuilder: (context, state) => _buildBrutalistPageTransition(
          context: context,
          state: state,
          child: HallOfDefameScreen(),
        ),
      ),

      // TODO: Add error route when error screen is created
      // GoRoute(
      //   path: RouteNames.error,
      //   name: 'error',
      //   pageBuilder: (context, state) => _buildBrutalistPageTransition(
      //     context: context,
      //     state: state,
      //     child: ErrorScreen(
      //       errorMessage: state.uri.queryParameters['message'],
      //     ),
      //   ),
      // ),
    ],

    errorPageBuilder: (context, state) => _buildBrutalistPageTransition(
      context: context,
      state: state,
      child: Scaffold(
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
    ),
  );

  /// Brutalist page transition - sharp, instant cuts
  /// Maintains the distress aesthetic with no smooth animations
  static Page _buildBrutalistPageTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Sharp cut transition at 50% - no fade, just instant
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return animation.value > 0.5 ? child! : Container();
          },
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 150),
    );
  }
}
