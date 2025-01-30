import 'package:flutter/material.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Nunito', // Set default font family
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.subTitle, // Apply global style
      displayMedium: AppTextStyles.bodyTextMedium, // Apply global style
      displaySmall: AppTextStyles.bodyTextSmall, // Apply global style
    ),
  );
}
