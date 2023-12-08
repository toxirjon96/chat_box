import 'package:flutter/material.dart';

import '../style/app_colors.dart';

final ColorScheme kColorSchema =
    ColorScheme.fromSeed(seedColor: AppColors.mainColor);

class ThemeConfig {
  const ThemeConfig._();

  static ThemeData theme = ThemeData(
    fontFamily: "Poppins",
    useMaterial3: true,
  ).copyWith(
    colorScheme: kColorSchema,
  );
}
