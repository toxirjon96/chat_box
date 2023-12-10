import 'package:flutter/material.dart';

import '../../../../common/style/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.height = 60,
    this.horizontalPadding = 20,
    this.verticalPadding = 0,
    super.key,
  });

  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.mainColor,
              AppColors.lightMainColor,
            ],
          ),
        ),
        child: SizedBox.expand(
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.background,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
