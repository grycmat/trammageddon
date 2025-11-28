import 'package:flutter/material.dart';
import 'package:trammageddon/screens/add_incident/app_dropdown.dart';
import 'package:trammageddon/screens/add_incident/app_text_area.dart';
import 'package:trammageddon/screens/add_incident/category_tag.dart';
import 'package:trammageddon/screens/add_incident/statement_frame.dart';
import 'package:trammageddon/screens/add_incident/wanted_border.dart';
import 'package:trammageddon/widgets/app_text_field.dart';
import 'package:trammageddon/widgets/stamped_button.dart';

class AddIncidentScreen extends StatefulWidget {
  const AddIncidentScreen({super.key});

  @override
  State<AddIncidentScreen> createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  final _vehicleNumberController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedLine;
  final Set<String> _selectedCategories = {'BRAK OGRZEWANIA/KLIMATYZACJI'};

  final List<String> _tramLines = [
    '1 - Cichy Kącik -> Elektromontaż',
    '2 - Salwator -> Cmentarz Rakowicki',
    '3 - Krowodrza Górka P+R -> Nowy Bieżanów P+R',
    '4 - Bronowice Małe -> Zajezdnia Nowa Huta',
    '5 - Krowodrza Górka P+R -> Elektromontaż',
    '6 - Cichy Kącik -> Mały Płaszów P+R',
    '8 - Bronowice Małe -> Borek Fałęcki',
    '9 - Rondo Hipokratesa -> Nowy Bieżanów P+R',
    '10 - Kurdwanów P+R -> Pleszów',
    '11 - Mały Płaszów P+R -> Czerwone Maki P+R',
    '13 - Bronowice -> Nowy Bieżanów P+R',
    '14 - Bronowice -> Os. Piastów',
    '16 - Mistrzejowice -> Bardosa',
    '17 - Dworzec Towarowy -> Czerwone Maki P+R',
    '18 - Górka Narodowa P+R -> Czerwone Maki P+R',
    '19 - Dworzec Towarowy -> Borek Fałęcki',
    '20 - Cichy Kącik -> Mały Płaszów P+R',
    '21 - Os. Piastów -> Pleszów',
    '22 - Borek Fałęcki -> Zajezdnia Nowa Huta',
    '24 - Bronowice Małe -> Kurdwanów P+R',
    '42 - Os. Piastów -> Kurdwanów P+R',
    '44 - Kopiec Wandy -> Dworzec Towarowy',
    '48 - Bronowice Małe -> Borek Fałęcki',
    '49 - TAURON Arena Kraków Wieczysta -> Nowy Bieżanów P+R',
    '50 - Górka Narodowa P+R -> Borek Fałęcki',
    '52 - Czerwone Maki P+R -> Os. Piastów',
    '62 - Plac Centralny im. R. Reagana -> Czerwone Maki P+R',
    '64 - Os. Piastów -> Bronowice Małe',
    '69 - Nowy Bieżanów P+R -> Górka Narodowa P+R',
    '72 - Mały Płaszów P+R -> Cmentarz Rakowicki',
    '75 - Górka Narodowa P+R -> Rondo Hipokratesa',
  ];

  final List<String> _categories = [
    'BRUD I SMRÓD',
    'UKROP',
    'ZIMNICA',
    'OCZYWIŚCIE SPÓŹNIENIE',
    'TŁOK',
    'AGRESYWNY PASAŻER',
    'SZALONA JAZDA',
    'WSZYSTKO NAJGORZEJ',
    'NIE LUBIĘ GO PO PROSTU',
  ];

  bool get _isFormValid {
    return _selectedLine != null && _descriptionController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _handleSubmit() {
    if (_isFormValid) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.report_problem,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          'PILNE ZAWIADOMIENIE',
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
                        AppDropdown(
                          value: _selectedLine,
                          items: _tramLines,
                          hint: 'WYBIERZ LINIĘ...',
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
                          hintText: 'NP. 1234 - ZWIĘKSZA SZANSE',
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
                          'OŚWIADCZENIE ŚWIADKA:',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 16),
                        AppTextArea(
                          controller: _descriptionController,
                          hintText:
                              'OPISZ PROBLEM WŁASNYMI SŁOWAMI. KAŻDY SZCZEGÓŁ MA ZNACZENIE. BĄDŹ PRECYZYJNY.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'CZY PASUJE DO KATEGORII?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _categories.map((category) {
                      return CategoryTag(
                        label: category,
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
              child: StampedButton(
                onPressed: _isFormValid ? _handleSubmit : null,
                icon: Icons.gavel,
                label: 'ZŁÓŻ OFICJALNE ZAWIADOMIENIE',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
