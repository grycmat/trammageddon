import 'package:flutter/material.dart';

class VerificationFrame extends StatelessWidget {
  final Widget child;

  const VerificationFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 4,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
