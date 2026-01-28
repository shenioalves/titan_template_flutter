import 'package:flutter/material.dart';

class ColorTheme {

  static const background = gray_500;
  static const dark_3 = Color(0xFF303030);
  static const dark = Color(0xFF424242);
  static const dark_2 = Color(0xFF383838);
  static const yellow = Color(0xFFF2A900);
  static const yellow_2 = Color(0xFFF2A900);
  static const gray_2 = Color(0xFF7D7D7D);
  static const gray_1 = Color(0xFFCCCCCC);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const brown_600 = Color(0xFF261000);
  static const brown_500 = Color(0xFF2F1600);
  static const brown_400 = Color(0xFF381E00);
  static const brown_300 = Color(0xFF492F00);
  static const brown_200 = Color(0xFFF5F0E9);

  static const green_900 = Color(0xFF002622);
  static const green_600 = Color(0xFF1A2600);
  static const green_500 = Color(0xFF3A4E00);
  static const green_400 = Color(0xFF587701);
  static const green_300 = Color(0xFF6E9F07);
  static const green_200 = Color(0xFFA3C714);
  static const green_150 = Color(0xFFEDDD5F);
  static const green_50 = Color(0xFFFDFDAB);
  static const green_10 = Color(0xFFFCFFCF);

  static const gray_600 = Color(0xFF262422);
  static const gray_500 = Color(0xFF4F4C49);
  static const gray_400 = Color(0xFF787470);
  static const gray_300 = Color(0xFFA19E99);
  static const gray_200 = Color(0xFFD1CEC8);
  static const gray_100 = Color(0xFFE3E2DE);

  static const error_50 = Color(0xFFFFF5F2);
  static const error_100 = Color(0xFFFCB4B4);
  static const error_200 = Color(0xFFE87D6E);
  static const error_300 = Color(0xFFB33A2A);
  static const error_400 = Color(0xFF4A0400);

  static const warning_50 = Color(0xFFFFF7F2);
  static const warning_100 = Color(0xFFFCDBB4);
  static const warning_300 = Color(0xFFB36C2A);
  static const warning_400 = Color(0xFF4A2400);

  static const success_50 = Color(0xFFF5FFF2);
  static const success_100 = Color(0xFFBAFCB4);
  static const success_200 = Color(0xFF8EE86E);
  static const success_300 = Color(0xFF4EB32A);
  static const success_400 = Color(0xFF1C4A00);

  static Color skeletonBase = Colors.grey[350]!;
  static Color skeletonHighlight = Colors.grey[100]!;

  static final LinearGradient otpGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      dark_3, 
      dark_3.withOpacity(0.1),
    ],
  );
}
