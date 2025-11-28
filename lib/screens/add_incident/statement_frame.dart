import 'package:flutter/material.dart';

class StatementFrame extends StatelessWidget {
  final Widget child;

  const StatementFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 3,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
