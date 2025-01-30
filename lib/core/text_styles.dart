import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle subTitle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 30, // px equivalent in Flutter
    fontWeight: FontWeight.w700, // 700 = bold
    height: 24 / 30, // line-height in Flutter is a multiplier, so 24/30
    letterSpacing: 0.15, // Converted from px
    decoration: TextDecoration.none, // No underline
  );
  static const TextStyle bodyTextMedium = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 22, // px equivalent in Flutter
    fontWeight: FontWeight.w700, // 700 = bold
    height: 24 / 30, // line-height in Flutter is a multiplier, so 24/30
    letterSpacing: 0.15, // Converted from px
    decoration: TextDecoration.none, // No underline
  );
  static const TextStyle bodyTextSmall = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 18, // px equivalent in Flutter
    fontWeight: FontWeight.w600, // 700 = bold
    height: 24 / 30, // line-height in Flutter is a multiplier, so 24/30
    letterSpacing: 0.15, // Converted from px
    decoration: TextDecoration.none, // No underline
  );
}
