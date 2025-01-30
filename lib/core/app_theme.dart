import 'package:flutter/material.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Nunito',
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.subTitle,
      displayMedium: AppTextStyles.bodyTextMedium,
      displaySmall: AppTextStyles.bodyTextSmall,
    ),
  );
}
