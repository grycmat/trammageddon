import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:trammageddon/screens/line_details/incident_card.dart';
import 'package:trammageddon/screens/line_details/line_details_header.dart';

class LineDetailsScreen extends StatefulWidget {
  final String lineNumber;

  const LineDetailsScreen({super.key, required this.lineNumber});

  @override
  State<LineDetailsScreen> createState() => _LineDetailsScreenState();
}

class _LineDetailsScreenState extends State<LineDetailsScreen> {
  late List<Incident> _incidents;
  final Map<String, bool> _votedIncidents = {};

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    _incidents = [
      Incident(
        id: '1',
        line: widget.lineNumber,
        description:
            'W DRUGIM WAGONIE NIEMIŁOSIERNIE ŚMIERDZI. PRAWDOPODOBNIE BEZDOMNY ŚPI NA KOŃCU SKŁADU.',
        categories: ['SMRÓD'],
        timestamp: DateTime.now().subtract(
          const Duration(hours: 0, minutes: 28),
        ),
        username: 'user1@example.com',
        userId: 'uid1',
        city: 'KRAKÓW',
      ),
      Incident(
        id: '2',
        line: widget.lineNumber,
        description:
            'TRAMWAJ MIAŁ BYĆ 10 MINUT TEMU. TABLICA NA PRZYSTANKU CENTRUM NIE DZIAŁA. ZAMARZAMY!',
        categories: ['SPÓŹNIENIE'],
        timestamp: DateTime.now().subtract(
          const Duration(hours: 0, minutes: 50),
        ),
        username: 'user2@example.com',
        userId: 'uid2',
        city: 'KRAKÓW',
      ),
      Incident(
        id: '3',
        line: widget.lineNumber,
        description:
            'NIE DA SIĘ WEJŚĆ, DRZWI SIĘ NIE DOMYKAJĄ. LUDZIE WISZĄ NA SCHODACH.',
        categories: ['TŁOK'],
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 15),
        ),
        username: 'user3@example.com',
        userId: 'uid3',
        city: 'KRAKÓW',
      ),
      Incident(
        id: '4',
        line: widget.lineNumber,
        description:
            'URWANE SIEDZENIE W KOŃCU SKŁADU. WYSTAJĄ NIEBEZPIECZNE KRAWĘDZIE I ŚRUBY. UWAŻAJCIE NA UBRANIA.',
        categories: ['NIEBEZPIECZNA AWARIA'],
        timestamp: DateTime.now().subtract(
          const Duration(hours: 2, minutes: 40),
        ),
        username: 'user4@example.com',
        userId: 'uid4',
        city: 'KRAKÓW',
      ),
      Incident(
        id: '5',
        line: widget.lineNumber,
        description:
            'AWANTURA O BILET PRZY WEJŚCIU. PASAŻER SZARPAŁ SIĘ Z KONTROLEREM. WEZWANO POLICJĘ.',
        categories: ['AGRESJA'],
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        username: 'user5@example.com',
        userId: 'uid5',
        city: 'KRAKÓW',
      ),
    ];

    for (final incident in _incidents) {
      _votedIncidents[incident.id!] = false;
    }

    _votedIncidents['2'] = true;
  }

  int _getUpvotes(String incidentId) {
    final mockUpvotes = {'1': 45, '2': 128, '3': 67, '4': 12, '5': 203};
    return mockUpvotes[incidentId] ?? 0;
  }

  void _handleUpvote(String incidentId) {
    setState(() {
      _votedIncidents[incidentId] = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: LineDetailsHeader(
        lineNumber: widget.lineNumber,
        totalReports: _incidents.length,
        onBack: () => context.pop(),
      ),
      body: Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              itemCount: _incidents.length,
              itemBuilder: (context, index) {
                final incident = _incidents[index];
                final hasImage = incident.id == '1' || incident.id == '3' || incident.id == '4';
                final isOld = incident.id == '5';
                return IncidentCard(
                  incident: incident,
                  upvotes: _getUpvotes(incident.id!),
                  hasVoted: _votedIncidents[incident.id!] ?? false,
                  onUpvote: () => _handleUpvote(incident.id!),
                  hasImage: hasImage,
                  isOld: isOld,
                );
              },
            ),
          ),


    );
  }
}
