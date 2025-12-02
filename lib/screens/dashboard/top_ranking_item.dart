import 'package:flutter/material.dart';

class TopRankingItem extends StatelessWidget {
  final int rank;
  final String line;
  final int reports;

  const TopRankingItem({
    super.key,
    required this.rank,
    required this.line,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontFamily: 'ChivoMono',
              color: Theme.of(context).colorScheme.primary,
            ),
            children: [
              TextSpan(text: '$rank. '),
              const TextSpan(text: 'LINIA '),
              TextSpan(text: line),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontFamily: 'ChivoMono',
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: [
              TextSpan(text: '$reports '),
              const TextSpan(text: 'ZGŁOSZEŃ'),
            ],
          ),
        ),
      ],
    );
  }
}
