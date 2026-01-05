import 'package:flutter/material.dart';
import 'package:trammageddon/model/incident.model.dart';
import 'package:intl/intl.dart';

class IncidentCard extends StatelessWidget {
  final Incident incident;
  final int upvotes;
  final bool hasVoted;
  final VoidCallback? onUpvote;
  final bool hasImage;
  final bool isOld;

  const IncidentCard({
    super.key,
    required this.incident,
    required this.upvotes,
    required this.hasVoted,
    this.onUpvote,
    this.hasImage = false,
    this.isOld = false,
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

    final categoryText = incident.categories.isNotEmpty
        ? incident.categories.first.toUpperCase()
        : 'INNE';

    final isAwaria = categoryText.contains('AWARIA');

    final cardOpacity = isOld ? 0.7 : 1.0;
    final textColor = isOld ? colorScheme.onSurfaceVariant : colorScheme.onSurface;

    return Opacity(
      opacity: cardOpacity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF141414).withValues(alpha: 0.9),
          border: const Border(
            left: BorderSide(
              color: Color(0xFFEF4444),
              width: 6,
            ),
            right: BorderSide(
              color: Color(0xFF333333),
              width: 2,
            ),
            top: BorderSide(
              color: Color(0xFF333333),
              width: 2,
            ),
            bottom: BorderSide(
              color: Color(0xFF333333),
              width: 2,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              right: 5,
              child: Text(
                'AKTA SPRAWY',
                style: textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  color: const Color(0xFF444444),
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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
                            color: isOld ? const Color(0xFF555555) : const Color(0xFF666666),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _formatTimestamp(incident.timestamp),
                          style: textTheme.labelSmall?.copyWith(
                            fontSize: 11,
                            color: isOld ? const Color(0xFF888888) : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: -0.035,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isAwaria
                                ? Colors.transparent
                                : (isOld ? const Color(0xFF555555) : colorScheme.primary),
                            border: Border.all(
                              color: isAwaria
                                  ? colorScheme.primary
                                  : (isOld ? const Color(0xFF555555) : theme.scaffoldBackgroundColor),
                              width: 1,
                              style: isAwaria ? BorderStyle.solid : BorderStyle.solid,
                            ),
                          ),
                          child: Text(
                            categoryText,
                            style: textTheme.labelSmall?.copyWith(
                              fontSize: 13,
                              color: isAwaria
                                  ? colorScheme.primary
                                  : (isOld ? colorScheme.onSurface : theme.scaffoldBackgroundColor),
                              fontWeight: FontWeight.w700,
                            ),
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
                      color: textColor,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1,
                    color: const Color(0xFF333333),
                  ),
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
                              side: BorderSide(
                                color: isOld
                                    ? const Color(0xFF555555)
                                    : (hasVoted ? colorScheme.onSurface : colorScheme.outline),
                                width: 1,
                              ),
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
                                  hasVoted ? Icons.check : Icons.thumb_up,
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
                              color: isOld ? const Color(0xFF888888) : colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      if (hasImage)
                        Icon(
                          Icons.image,
                          color: const Color(0xFF666666),
                          size: 20,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
