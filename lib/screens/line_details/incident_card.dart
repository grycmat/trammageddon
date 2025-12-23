import 'package:flutter/material.dart';
import 'package:trammageddon/model/incident.model.dart';

class IncidentCard extends StatelessWidget {
  final Incident incident;

  const IncidentCard({
    super.key,
    required this.incident,
  });

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} MIN TEMU';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} GODZ TEMU';
    } else if (difference.inDays == 1) {
      return 'WCZORAJ';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} DNI TEMU';
    } else {
      final day = timestamp.day.toString().padLeft(2, '0');
      final month = timestamp.month.toString().padLeft(2, '0');
      final year = timestamp.year.toString();
      return '$day.$month.$year';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTimestamp(incident.timestamp),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                if (incident.vehicleNumber != null &&
                    incident.vehicleNumber!.isNotEmpty)
                  Text(
                    'POJAZD ${incident.vehicleNumber}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OPIS INCYDENTU',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  incident.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'KATEGORIE',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: incident.categories.map((category) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.tertiaryContainer,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
