import 'package:flutter/material.dart';

class LineDetailsHeader extends StatelessWidget implements PreferredSizeWidget {
  final String lineNumber;
  final VoidCallback? onBack;

  const LineDetailsHeader({
    super.key,
    required this.lineNumber,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppBar(title: Text("REJESTR ZGŁOSZEŃ"), leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: onBack ?? () {},
      color: colorScheme.onSurface,
    ),);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);}

class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;

  const DashedBorder({
    super.key,
    required this.child,
    required this.color,
    this.strokeWidth = 1,
    this.dashPattern = const [5, 5],
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashPattern: dashPattern,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      bool draw = true;
      int dashIndex = 0;

      while (distance < metric.length) {
        final dashLength = dashPattern[dashIndex % dashPattern.length];
        if (draw) {
          final extractPath = metric.extractPath(
            distance,
            distance + dashLength > metric.length
                ? metric.length
                : distance + dashLength,
          );
          canvas.drawPath(extractPath, paint);
        }
        distance += dashLength;
        draw = !draw;
        dashIndex++;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashPattern != dashPattern;
  }
}
