import 'package:flutter/material.dart';
import 'package:trammageddon/routing/app_router.dart';
import 'package:trammageddon/routing/guards/auth_guard.dart';
import 'package:trammageddon/theme/theme.dart';

void main() {
  runApp(const Trammageddon());
}

class Trammageddon extends StatefulWidget {
  const Trammageddon({super.key});

  @override
  State<Trammageddon> createState() => _TrammageddonState();
}

class _TrammageddonState extends State<Trammageddon> {
  late final AuthGuard _authGuard;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authGuard = AuthGuard();
    _appRouter = AppRouter(authGuard: _authGuard);
  }

  @override
  void dispose() {
    _authGuard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Trammageddon',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: _appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
