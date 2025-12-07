import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trammageddon/firebase_options.dart';
import 'package:trammageddon/routing/app_router.dart';
import 'package:trammageddon/routing/guards/auth_guard.dart';
import 'package:trammageddon/services/auth.service.dart';
import 'package:trammageddon/services/incident.service.dart';
import 'package:trammageddon/services/preferences.service.dart';
import 'package:trammageddon/theme/theme.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  getIt.registerSingleton<IncidentService>(IncidentService());
  getIt.registerSingletonAsync<PreferencesService>(
    () => PreferencesService.init(),
  );
  getIt.registerSingletonAsync<AuthGuard>(
    () async => AuthGuard(getIt.get<PreferencesService>()),
    dependsOn: [PreferencesService],
  );
  getIt.registerSingletonAsync(
    () async => AuthService.init(getIt.get<PreferencesService>()),
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
