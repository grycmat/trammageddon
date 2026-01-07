import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/data/categories.dart';
import 'package:trammageddon/data/tram_lines.dart';
import 'package:trammageddon/model/category.model.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/model/tram_line.model.dart';
import 'package:trammageddon/screens/add_incident/app_dropdown.dart';
import 'package:trammageddon/screens/add_incident/app_text_area.dart';
import 'package:trammageddon/screens/add_incident/category_tag.dart';
import 'package:trammageddon/screens/add_incident/statement_frame.dart';
import 'package:trammageddon/screens/add_incident/wanted_border.dart';
import 'package:trammageddon/services/auth.service.dart';
import 'package:trammageddon/services/incident.service.dart';
import 'package:trammageddon/widgets/app_text_field.dart';
import 'package:trammageddon/widgets/stamped_button.dart';

final getIt = GetIt.I;

class AddIncidentScreen extends StatefulWidget {
  const AddIncidentScreen({super.key});

  @override
  State<AddIncidentScreen> createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  final _vehicleNumberController = TextEditingController();
  final _descriptionController = TextEditingController();
  TramLine? _selectedLine;
  final Set<Category> _selectedCategories = {};
  bool _isSubmitting = false;
  final _authService = getIt.get<AuthService>();
  final _incidentService = getIt.get<IncidentService>();

  bool get _isFormValid {
    return _selectedLine != null && _descriptionController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    final defaultCategory = kCategories.firstWhere(
      (c) => c.label == 'BRAK OGRZEWANIA/KLIMATYZACJI',
      orElse: () => kCategories.first,
    );
    _selectedCategories.add(defaultCategory);

    _descriptionController.addListener(() {
      setState(() {});
    });
  }

  void _toggleCategory(Category category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  Future<void> _handleSubmit() async {
    if (!_isFormValid) return;
    setState(() => _isSubmitting = true);

    try {
      final isAnonymous = _authService.isAnonymous;
      final incident = Incident(
        line: _selectedLine!.number,
        vehicleNumber: _vehicleNumberController.text.isNotEmpty
            ? _vehicleNumberController.text
            : null,
        description: _descriptionController.text,
        categories: _selectedCategories
            .map((c) => c.label)
            .toList(),
        timestamp: DateTime.now(),
        username: isAnonymous ? 'ANONIM' : _authService.username ?? '',
        userId: isAnonymous ? '' : _authService.userId ?? '',
        city: 'KRAKÓW',
      );

      await _incidentService.addIncident(incident);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('ŻALE WYLANE POMYŚLNIE!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('BŁĄD: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_back,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        title: Text(
          'UWAGA UWAGA UWAGA',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WantedBorder(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'SZCZEGÓŁY ZDARZENIA',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'LINIA TRAMWAJOWA*',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        AppDropdown<TramLine>(
                          value: _selectedLine,
                          items: kTramLines,
                          hint: 'WYBIERZ LINIĘ...',
                          itemLabelBuilder: (item) => item.formatted,
                          onChanged: (value) {
                            setState(() {
                              _selectedLine = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'NUMER BOCZNY POJAZDU (OPCJONALNIE)',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        AppTextField(
                          controller: _vehicleNumberController,
                          hintText: 'NP. 1234 - WIĘKSZY WSTYD',
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  StatementFrame(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'WYLEJ SWE ŻALE:',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 16),
                        AppTextArea(
                          controller: _descriptionController,
                          hintText:
                              'WRESZCIE MOŻESZ SIĘ WYŻALIĆ. NIKT Z TYM NIC NIE ZROBI, GWARANTUJĘ',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'CO TO?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: kCategories.map((category) {
                      return CategoryTag(
                        label: category.label,
                        isSelected: _selectedCategories.contains(category),
                        onTap: () => _toggleCategory(category),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
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
            child: SafeArea(
              top: false,
              child: _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : StampedButton(
                      onPressed: _isFormValid ? _handleSubmit : null,
                      icon: Icons.gavel,
                      label: 'WYŚLIJ ME ŻALE',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
