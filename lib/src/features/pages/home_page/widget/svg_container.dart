import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgContainer extends StatelessWidget {
  const SvgContainer({
    required this.svgPath,
    required this.backgroundColor,
    this.size = 50,
    super.key,
  });

  final double size;
  final String svgPath;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          svgPath,
        ),
      ),
    );
  }
}
