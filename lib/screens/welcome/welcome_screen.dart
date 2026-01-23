import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/main.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/screens/welcome/info_box/info_box.dart';
import 'package:trammageddon/services/preferences.service.dart';
import 'package:trammageddon/widgets/stamped_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _handleGetStarted(BuildContext context) async {
    final preferencesService = getIt.get<PreferencesService>();
    await preferencesService.setOnboardingComplete();
    if (context.mounted) {
      context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 4,
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            size: 80,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'TRAMMAGEDDON',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  letterSpacing: 4,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    const InfoBox(title: 'ZGŁASZAJ INCYDENTY', desc: 'BRUD, SMRÓD, AWARIE - SMACZNEGO!'),
                    const SizedBox(height: 16),
                    const InfoBox(title: 'ŚLEDŹ STATYSTYKI', desc: 'ZOBACZ KTÓRE LINIE SĄ NAJGORSZE'),
                    const SizedBox(height: 16),
                    const InfoBox(title: 'HALA WSTYDU', desc: 'RANKING NAJGORSZYCH Z NAJGORSZYCH'),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: StampedButton(
                onPressed: () => _handleGetStarted(context),
                icon: Icons.arrow_forward,
                label: 'ZACZYNAMY',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
