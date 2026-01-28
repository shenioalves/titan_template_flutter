import 'package:flutter/material.dart';

enum TitanTypography {
  // Display Styles
  displayMdBold(24, FontWeight.w700, 'Poppins Bold'),

  // Title Styles
  titleMdSemibold(16, FontWeight.w600, 'Poppins Bold'),
  titleLargeLight(16, FontWeight.w300, 'Poppins'),
  titleLarge(16, FontWeight.w700, 'Poppins'),
  titleLgMedium(16, FontWeight.w500, 'Poppins'),

  // Subtitle Styles
  subtitleMdMedium(14, FontWeight.w500, 'Poppins'),

  // Text Styles
  text(14, FontWeight.w300, 'Poppins'),
  textLgLight(16, FontWeight.w400, 'Poppins'),

  // Body Styles
  bodySmall(12, FontWeight.w400, 'Poppins'),

  // Custom Button Style
  buttonMd(14, FontWeight.w600, 'Poppins'),
  buttonLarge(14, FontWeight.w500, 'Poppins'),
  buttonSmall(12, FontWeight.w500, 'Poppins');

  const TitanTypography(this.size, this.weight, this.fontFamily);

  final double size;
  final FontWeight weight;
  final String fontFamily;

  TextStyle get style => TextStyle(
    fontSize: size,
    fontWeight: weight,
  );
}
