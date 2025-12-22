import 'package:flutter/material.dart';
import 'package:trammageddon/screens/add_incident/statement_frame.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return StatementFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'NAJCZĘSTSZE OKROPIEŃSTWA:',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 12, runSpacing: 12, children: []),
        ],
      ),
    );
  }
}
