
import 'package:flutter/material.dart';

import '../../utils/responsive_utils.dart';
import '../legacy/color_theme.dart';
import '../legacy/titan_typography.dart';

class TitanText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TitanTypography typography;
  final TextDecoration? decoration;
  final String? fontFamily;
  
  const TitanText({
    super.key,
    required this.text,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.typography = TitanTypography.text,
    this.fontFamily = 'Inter',
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtils responsiveUtils = ResponsiveUtils();
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: color ?? ColorTheme.white,
            fontFamily: fontFamily ?? typography.style.fontFamily,
            fontSize: (fontSize ?? typography.style.fontSize!) *
                responsiveUtils.getTextScale(context),
            fontWeight: fontWeight ?? typography.style.fontWeight,
            letterSpacing: typography.style.letterSpacing,
            decoration: decoration,
          ),
    );
  }
}
