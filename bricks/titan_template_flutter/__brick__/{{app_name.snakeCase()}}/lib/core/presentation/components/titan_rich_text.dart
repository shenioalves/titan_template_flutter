import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive_utils.dart';
import '../legacy/color_theme.dart';
import '../legacy/titan_typography.dart';


class TitanTextSpan extends TextSpan {
  TitanTextSpan({
    required String text,
    required BuildContext context,
    double? fontSize,
    FontWeight? fontWeight,
    TitanTypography typography = TitanTypography.bodySmall,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    Color? backgroundColor,
    List<TextSpan>? children,
    VoidCallback? onTap,
  }) : super(
          text: text,
          style: buildStyle(
            context,
            typography,
            fontSize,
            fontWeight,
            color,
            decoration,
            decorationColor,
            backgroundColor,
          ),
          children: children,
          recognizer: (TapGestureRecognizer()..onTap = onTap),
        );

  static TextStyle buildStyle(
    BuildContext context,
    TitanTypography typography,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    Color? backgroundColor,
  ) {
    final ResponsiveUtils responsiveUtils = ResponsiveUtils();
    final TextStyle baseStyle =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle();

    return baseStyle.copyWith(
      fontFamily: typography.fontFamily,
      fontSize:
          (fontSize ?? typography.size) * responsiveUtils.getTextScale(context),
      fontWeight: fontWeight ?? typography.weight,
      color: color ?? ColorTheme.white,
      decoration: decoration,
      decorationColor: decorationColor ?? color ?? ColorTheme.white,
      backgroundColor: backgroundColor,
    );
  }
}

class TitanRichText extends StatelessWidget {
  final List<TitanTextSpan> textSpans;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final TitanTypography typography;
  final Color? defaultColor;
  final VoidCallback? onTap;

  const TitanRichText({
    required this.textSpans,
    super.key,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.typography = TitanTypography.bodySmall,
    this.defaultColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtils responsiveUtils = ResponsiveUtils();
    final TextStyle baseStyle =
        (Theme.of(context).textTheme.bodyMedium ?? const TextStyle()).copyWith(
      fontSize: typography.size * responsiveUtils.getTextScale(context),
      fontWeight: typography.weight,
      color: defaultColor ?? ColorTheme.white,
    );

    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(style: baseStyle, children: textSpans),
        textAlign: textAlign,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        locale: locale,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      ),
    );
  }
}
