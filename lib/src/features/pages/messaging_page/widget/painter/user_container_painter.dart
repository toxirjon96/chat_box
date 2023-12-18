import 'dart:math';
import 'package:flutter/material.dart';

class UserContainerPainter extends CustomPainter {
  const UserContainerPainter({
    this.strokeWidth = 3.0,
    this.selfContainer = true,
    this.borderColor = Colors.white,
    this.selfTopColor = Colors.white,
  });
  final bool selfContainer;
  final double strokeWidth;
  final Color borderColor;
  final Color selfTopColor;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = borderColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    if (selfContainer){
      canvas.drawArc(
        Rect.fromPoints(Offset(strokeWidth / 2, 0), Offset(w - strokeWidth / 2, h)),
        7 * pi / 4 + pi / 36,
        pi / 2 - pi / 36,
        false,
        paint,
      );
      canvas.drawArc(
        Rect.fromPoints(Offset(strokeWidth / 2, 0), Offset(w - strokeWidth / 2, h)),
        pi / 3,
        pi / 3 + pi / 36,
        false,
        paint,
      );

      canvas.drawArc(
        Rect.fromPoints(Offset(strokeWidth / 2, 0), Offset(w - strokeWidth / 2, h)),
        3* pi / 4 + pi / 36,
        pi / 2 - pi / 36,
        false,
        paint,
      );
      final paint1 = Paint()
        ..color = selfTopColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        Rect.fromPoints(Offset(strokeWidth / 2, 0), Offset(w - strokeWidth / 2, h)),
        4 * pi / 3,
        pi / 3 + pi / 36,
        false,
        paint1,
      );
    }else{
      canvas.drawCircle(Offset(w / 2, h / 2), w / 2 - strokeWidth / 2, paint);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
