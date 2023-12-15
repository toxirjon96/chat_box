import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../common/style/app_colors.dart';

class UserContainerPainter extends CustomPainter {
  const UserContainerPainter({
    this.strokeWidth = 3.0,
  });

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = AppColors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromPoints(Offset.zero, Offset(w, h)),
      7 * pi / 4 + pi / 36,
      pi / 2 - pi / 36,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromPoints(Offset.zero, Offset(w, h)),
      pi / 2,
      pi / 2 - pi / 36,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
