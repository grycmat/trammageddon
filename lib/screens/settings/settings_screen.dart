import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/routing/route_names.dart';
import 'package:trammageddon/screens/add_incident/app_dropdown.dart';
import 'package:trammageddon/services/auth.service.dart';
import 'package:trammageddon/services/preferences.service.dart';
import 'package:trammageddon/widgets/app_text_field.dart';
import 'package:trammageddon/widgets/stamped_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _usernameController = TextEditingController();
  final _authService = GetIt.I.get<AuthService>();
  String? _selectedTheme;
  String? _selectedCity;
  bool _isSaving = false;
  String _initialUsername = '';

  final List<String> _themeOptions = ['JASNY', 'CIEMNY', 'SYSTEMOWY'];

  final List<String> _cityOptions = ['KRAKÓW'];

  bool get _isAnonymous => _authService.isAnonymous;

  @override
  void initState() {
    super.initState();
    _selectedCity = 'KRAKÓW';
    _usernameController.addListener(_onUsernameChanged);
    _loadUsername();
  }

  void _onUsernameChanged() {
    setState(() {});
  }

  Future<void> _loadUsername() async {
    final preferenceService = GetIt.I.get<PreferencesService>();
    final savedUsername = preferenceService.getUsername() ?? '';
    setState(() {
      _initialUsername = savedUsername;
      _usernameController.text = savedUsername;
    });
  }

  bool get _hasUsernameChanged {
    return _usernameController.text != _initialUsername;
  }

  Future<void> _saveUsername() async {
    if (_isSaving || !_hasUsernameChanged) return;

    final newUsername = _usernameController.text.trim();
    if (newUsername.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'NAZWA UŻYTKOWNIKA NIE MOŻE BYĆ PUSTA',
              style: TextStyle(
                fontFamily: 'ChivoMono',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final preferenceService = GetIt.I.get<PreferencesService>();
      await preferenceService.saveUsername(newUsername);

      setState(() {
        _initialUsername = newUsername;
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'NAZWA UŻYTKOWNIKA ZAPISANA',
              style: TextStyle(
                fontFamily: 'ChivoMono',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'BŁĄD ZAPISU: ${e.toString()}',
              style: TextStyle(
                fontFamily: 'ChivoMono',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _handleLogout() async {
    await _authService.logout();
    if (mounted) {
      context.go(RouteNames.login);
    }
  }

  Future<void> _handleRegister() async {
    await _authService.logout();
    if (mounted) {
      context.go(RouteNames.login);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'MOTYW',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                AppDropdown<String>(
                  value: _selectedTheme,
                  items: _themeOptions,
                  hint: 'WYBIERZ MOTYW...',
                  itemLabelBuilder: (item) => item,
                  onChanged: (value) {
                    setState(() {
                      _selectedTheme = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'DANE UŻYTKOWNIKA',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                if (_isAnonymous)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'ANONIM',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                else ...[
                  AppTextField(
                    controller: _usernameController,
                    hintText: 'WPROWADŹ NAZWĘ',
                  ),
                  const SizedBox(height: 16),
                  _isSaving
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : StampedButton(
                          onPressed: _hasUsernameChanged ? _saveUsername : null,
                          icon: Icons.save,
                          label: 'ZAPISZ',
                        ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'MIASTO',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                AppDropdown<String>(
                  value: _selectedCity,
                  items: _cityOptions,
                  hint: 'WYBIERZ MIASTO...',
                  itemLabelBuilder: (item) => item,
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'WKRÓTCE W KOLEJNYCH MIASTACH!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'KONTO',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                if (_isAnonymous) ...[
                  StampedButton(
                    onPressed: _handleRegister,
                    icon: Icons.person_add,
                    label: 'ZAREJESTRUJ SIĘ',
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: _handleLogout,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'WYJDŹ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ] else
                  OutlinedButton(
                    onPressed: _handleLogout,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'WYLOGUJ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
