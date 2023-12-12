import 'package:flutter/material.dart';

import '../../../../../common/style/app_colors.dart';

class UserContainerPainter extends CustomPainter {
  const UserContainerPainter({
    this.strokeWidth = 5.0,
  });

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = AppColors.lightMainColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(w / 2, h / 2), w / 2 - strokeWidth, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
