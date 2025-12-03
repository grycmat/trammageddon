import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/routing/app_router.dart';
import 'package:trammageddon/routing/guards/auth_guard.dart';
import 'package:trammageddon/services/preferences_service.dart';
import 'package:trammageddon/theme/theme.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingletonAsync<PreferencesService>(
    () => PreferencesService.init(),
  );
  getIt.registerSingletonAsync<AuthGuard>(
    () async => AuthGuard(getIt.get<PreferencesService>()),
    dependsOn: [PreferencesService],
  );
  await getIt.allReady();
  runApp(Trammageddon());
}

class Trammageddon extends StatefulWidget {
  const Trammageddon({super.key});

  @override
  State<Trammageddon> createState() => _TrammageddonState();
}

class _TrammageddonState extends State<Trammageddon> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
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
