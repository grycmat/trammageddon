import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trammageddon/model/incident.model.dart';

class IncidentCard extends StatelessWidget {
  final Incident incident;
  final int upvotes;
  final bool hasVoted;
  final VoidCallback? onUpvote;

  const IncidentCard({
    super.key,
    required this.incident,
    required this.upvotes,
    required this.hasVoted,
    this.onUpvote,
  });

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final incidentDate = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
    );

    final time = DateFormat('HH:mm').format(timestamp);

    if (incidentDate == today) {
      return '$time | DZIŚ';
    } else if (incidentDate == today.subtract(const Duration(days: 1))) {
      return '$time | WCZORAJ';
    } else {
      return '$time | ${DateFormat('dd.MM').format(timestamp).toUpperCase()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414).withValues(alpha: 0.9),
        border: const Border(
          left: BorderSide(color: Color(0xFFEF4444), width: 6),
          right: BorderSide(color: Color(0xFF333333), width: 2),
          top: BorderSide(color: Color(0xFF333333), width: 2),
          bottom: BorderSide(color: Color(0xFF333333), width: 2),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'ChivoMono',
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: [
                  const TextSpan(text: 'LINIA '),
                  TextSpan(text: incident.line),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 44, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        border: Border.all(
                          color: const Color(0xFF666666),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _formatTimestamp(incident.timestamp),
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  incident.description,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Container(height: 1, color: const Color(0xFF333333)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: hasVoted ? null : (onUpvote ?? () {}),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: hasVoted
                                ? colorScheme.onSurface
                                : Colors.transparent,
                            foregroundColor: hasVoted
                                ? theme.scaffoldBackgroundColor
                                : colorScheme.onSurface,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: Size.zero,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                hasVoted ? Icons.check : Icons.thunderstorm,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                hasVoted ? 'PODBITO' : 'PODBIJ',
                                style: textTheme.labelSmall?.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          upvotes.toString(),
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
