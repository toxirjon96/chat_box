import 'package:chat_box/src/common/style/app_colors.dart';
import 'package:flutter/material.dart';

final ColorScheme kColorSchema =
    ColorScheme.fromSeed(seedColor: AppColors.mainColor);

class ThemeConfig {
  const ThemeConfig._();

  static ThemeData theme = ThemeData(fontFamily: "Poppins").copyWith(
    useMaterial3: true,
    colorScheme: kColorSchema,
  );

}
