import 'package:flutter/material.dart';

class StampedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;

  const StampedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  State<StampedButton> createState() => _StampedButtonState();
}

class _StampedButtonState extends State<StampedButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..rotateZ(
            _isPressed ? -0.017 : -0.052,
          )
          ..scale(_isPressed ? 0.98 : 1.0),
        transformAlignment: Alignment.center,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: isEnabled
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
            border: Border.all(
              color: isEnabled
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              width: 3,
            ),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      blurRadius: _isPressed ? 2 : 15,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                      blurRadius: _isPressed ? 2 : 5,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: isEnabled
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isEnabled
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      letterSpacing: 2,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
