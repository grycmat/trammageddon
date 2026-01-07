import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/routing/route_names.dart';

class DetailedRankingEntry extends StatelessWidget {
  final int rank;
  final String line;
  final int incidents;

  const DetailedRankingEntry({
    super.key,
    required this.rank,
    required this.line,
    required this.incidents,
  });

  String _formatRank(int rank) {
    return rank.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed("${RouteNames.lineDetails}/$line");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _formatRank(rank),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontFamily: 'ChivoMono',
                  color: Theme.of(context).colorScheme.primary,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDivider(context),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'LINIA '),
                        TextSpan(
                          text: line,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDivider(context),
                  const SizedBox(height: 8),
                  Text(
                    'LICZBA INCYDENTÓW:',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    incidents.toString(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: 'ChivoMono',
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDivider(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
    );
  }
}
