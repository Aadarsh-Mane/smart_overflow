import 'package:flutter/material.dart';

class OverflowDebugPainter extends CustomPainter {
  final Color color;
  final double opacity;
  final bool showOverflow;

  OverflowDebugPainter({
    required this.color,
    required this.opacity,
    required this.showOverflow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!showOverflow) return;

    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    // Draw overflow indicator
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    // Draw border
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
