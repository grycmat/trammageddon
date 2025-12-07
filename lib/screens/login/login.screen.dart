import 'package:flutter/material.dart';
import 'package:trammageddon/main.dart';
import 'package:trammageddon/routing/guards/auth_guard.dart';
import 'package:trammageddon/widgets/app_text_field.dart';
import 'package:trammageddon/widgets/stamped_button.dart';
import 'package:trammageddon/widgets/verification_frame.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isLoading = false;
  bool isRegisterMode = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkFields);
    _loadSavedUsername();
  }

  Future<void> _loadSavedUsername() async {
    final authGuard = getIt.get<AuthGuard>();
    final savedUsername = authGuard.username;
    if (savedUsername != null && savedUsername.isNotEmpty) {
      _usernameController.text = savedUsername;
    }
  }

  void _checkFields() {
    setState(() {
      _isButtonEnabled = _usernameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_isButtonEnabled || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authGuard = getIt.get<AuthGuard>();
      await authGuard.login(_usernameController.text);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'BŁĄD LOGOWANIA: ${e.toString()}',
              style: const TextStyle(
                fontFamily: 'ChivoMono',
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BEZPIECZNY DOSTĘP',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: VerificationFrame(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'DANE WERYFIKACYJNE',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'NAZWA UŻYTKOWNIKA',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        controller: _usernameController,
                        hintText: 'TAK PODPISZESZ SWOJE ŻALE',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        controller: _usernameController,
                        hintText: 'HASŁO, ZERO BEZPIECZEŃSTWA',
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
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
            child: SafeArea(
              top: false,
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : StampedButton(
                      onPressed: _isButtonEnabled ? _handleLogin : null,
                      icon: Icons.login,
                      label: isRegisterMode ? 'REJESTRACJA' : 'ZALOGUJ SIĘ',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
