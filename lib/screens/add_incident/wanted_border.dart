import 'package:flutter/material.dart';

class WantedBorder extends StatelessWidget {
  final Widget child;

  const WantedBorder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: Theme.of(context).colorScheme.primary,
        strokeWidth: 4,
        dashWidth: 8,
        dashSpace: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    _drawDashedLine(
      canvas,
      paint,
      Offset(0, 0),
      Offset(size.width, 0),
    );

    _drawDashedLine(
      canvas,
      paint,
      Offset(size.width, 0),
      Offset(size.width, size.height),
    );

    _drawDashedLine(
      canvas,
      paint,
      Offset(size.width, size.height),
      Offset(0, size.height),
    );

    _drawDashedLine(
      canvas,
      paint,
      Offset(0, size.height),
      Offset(0, 0),
    );
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = (dx * dx + dy * dy).squareRoot();
    final unitDx = dx / distance;
    final unitDy = dy / distance;

    double currentDistance = 0;
    while (currentDistance < distance) {
      final dashEnd = (currentDistance + dashWidth).clamp(0, distance);
      canvas.drawLine(
        Offset(
          start.dx + unitDx * currentDistance,
          start.dy + unitDy * currentDistance,
        ),
        Offset(
          start.dx + unitDx * dashEnd,
          start.dy + unitDy * dashEnd,
        ),
        paint,
      );
      currentDistance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashWidth != oldDelegate.dashWidth ||
      dashSpace != oldDelegate.dashSpace;
}

extension SquareRoot on double {
  double squareRoot() {
    if (this < 0) return 0;
    double x = this;
    double y = 1;
    double e = 0.000001;
    while (x - y > e) {
      x = (x + y) / 2;
      y = this / x;
    }
    return x;
  }
}
