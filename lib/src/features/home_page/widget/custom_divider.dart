import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    required this.horizontalPadding,
    required this.color,
    this.centerWidget,
    this.thickness = 2,
    super.key,
  });

  final double horizontalPadding;
  final double thickness;
  final Color color;
  final Widget? centerWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Divider(
                color: color,
                thickness: thickness,
              ),
            ),
            Expanded(
              child: Align(
                child: centerWidget,
              ),
            ),
            Expanded(
              flex: 2,
              child: Divider(
                thickness: thickness,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
