import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trammageddon/routing/app_router.dart';
import 'package:trammageddon/routing/guards/auth_guard.dart';
import 'package:trammageddon/services/preferences_service.dart';
import 'package:trammageddon/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesService = await PreferencesService.getInstance();
  runApp(Trammageddon(preferencesService: preferencesService));
}

class Trammageddon extends StatefulWidget {
  final PreferencesService preferencesService;

  const Trammageddon({super.key, required this.preferencesService});

  @override
  State<Trammageddon> createState() => _TrammageddonState();
}

class _TrammageddonState extends State<Trammageddon> {
  late final AuthGuard _authGuard;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authGuard = AuthGuard(widget.preferencesService);
    _appRouter = AppRouter(authGuard: _authGuard);
  }

  @override
  void dispose() {
    _authGuard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authGuard,
      child: MaterialApp.router(
        title: 'Trammageddon',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        routerConfig: _appRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
