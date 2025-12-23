import 'package:flutter/material.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/screens/line_details/incident_card.dart';

class LineDetailsScreen extends StatelessWidget {
  final String lineNumber;

  const LineDetailsScreen({
    super.key,
    required this.lineNumber,
  });

  List<Incident> _getMockIncidents() {
    final now = DateTime.now();

    return [
      Incident(
        id: 'mock_1',
        line: lineNumber,
        vehicleNumber: '2001',
        description: 'OKROPNY SMRÓD W CAŁYM WAGONIE, NIEMOŻLIWE DO WYTRZYMANIA',
        categories: ['BRUD I SMRÓD', 'WSZYSTKO NAJGORZEJ'],
        timestamp: now.subtract(const Duration(hours: 2)),
        username: 'UŻYTKOWNIK_123',
        userId: 'user_1',
        city: 'KRAKÓW',
      ),
      Incident(
        id: 'mock_2',
        line: lineNumber,
        vehicleNumber: '2045',
        description: 'ZIMNO JAK W LODÓWCE, KLIMATYZACJA NA MAKSA W ŚRODKU ZIMY',
        categories: ['ZIMNICA', 'BRAK OGRZEWANIA/KLIMATYZACJI'],
        timestamp: now.subtract(const Duration(hours: 5)),
        username: 'ZDENERWOWANY_PASAŻER',
        userId: 'user_2',
        city: 'KRAKÓW',
      ),
      Incident(
        id: 'mock_3',
        line: lineNumber,
        vehicleNumber: '2033',
        description: 'SPÓŹNIENIE 20 MINUT, TŁOK JAK W PUSZCE SARDYNEK',
        categories: ['OCZYWIŚCIE SPÓŹNIENIE', 'TŁOK', 'WSZYSTKO NAJGORZEJ'],
        timestamp: now.subtract(const Duration(hours: 12)),
        username: 'NIECIERPLIWY',
        userId: 'user_3',
        city: 'KRAKÓW',
      ),
      Incident(
        id: 'mock_4',
        line: lineNumber,
        vehicleNumber: '2017',
        description: 'AGRESYWNY PASAŻER KRZYCZAŁ NA WSZYSTKICH',
        categories: ['AGRESYWNY PASAŻER'],
        timestamp: now.subtract(const Duration(days: 1)),
        username: 'PRZERAŻONY_OBSERWATOR',
        userId: 'user_4',
        city: 'KRAKÓW',
      ),
      Incident(
        id: 'mock_5',
        line: lineNumber,
        vehicleNumber: '2028',
        description: 'KIEROWCA JEŹDZIŁ JAK WARIAT, HAMOWAŁ NA KAŻDYM PRZYSTANKU',
        categories: ['SZALONA JAZDA', 'NIEBEZPIECZNA JAZDA'],
        timestamp: now.subtract(const Duration(days: 2)),
        username: 'ZMARTWIONY_PASAŻER',
        userId: 'user_5',
        city: 'KRAKÓW',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final incidents = _getMockIncidents();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: [
              const TextSpan(text: 'LINIA '),
              TextSpan(
                text: lineNumber,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              'OSTATNIE ZGŁOSZENIA',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: incidents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < incidents.length - 1 ? 16 : 0,
                  ),
                  child: IncidentCard(incident: incidents[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
