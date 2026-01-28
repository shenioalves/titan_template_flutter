import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../legacy/color_theme.dart';
import '../legacy/titan_typography.dart';
import 'titan_text.dart';

class TitanButton extends StatelessWidget {
  ///Texto do Botão
  final String label;

  ///Cor do texto do botão
  final Color? labelColor;

  ///Cor de fundo do botão
  final Color? backgroundColor;

  ///Se o botão vai ter borda
  final bool border;

  ///O que o botão ira fazer ao pressionar
  final void Function() onPressed;

  ///Margem do botão
  final EdgeInsetsGeometry? margin;

  ///Cor da borda
  final Color? bordeColor;

  ///Largura
  final double? width;

  /// Suffixo do botão ( Widget que vem depois da label )
  final Widget? suffix;

  /// Se o botão está carregando
  final bool isLoading;

  /// Prefixo do botão ( Widget que vem antes da label )
  final Widget? prefix;

  ///Chave do formulário
  final GlobalKey<FormState>? formKey;

  const TitanButton({
    super.key,
    required this.label,
    this.labelColor = ColorTheme.white,
    this.backgroundColor,
    required this.onPressed,
    this.margin,
    this.width,
    this.suffix,
    this.isLoading = false,
    this.prefix,
    this.formKey,
  })  : border = false,
        bordeColor = Colors.transparent;

  const TitanButton.outline({
    super.key,
    required this.label,
    this.labelColor = ColorTheme.white,
    this.backgroundColor = Colors.transparent,
    required this.onPressed,
    this.margin,
    this.bordeColor,
    this.width,
    this.suffix,
    this.isLoading = false,
    this.prefix,
    this.formKey,
  }) : border = true;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () {
        if (formKey != null) {
          if (!formKey!.currentState!.validate()) {
            return;
          }
        }

        if (isLoading) {
          return;
        }

        onPressed();
      },
      child: Container(
        height: 48,
        margin: margin,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorTheme.yellow,
          borderRadius: BorderRadius.circular(4),
          border: border
              ? Border.all(
                  width: 1,
                  color: bordeColor ?? ColorTheme.green_600,
                )
              : const Border(),
        ),
        child: isLoading
            ? LoadingAnimationWidget.fourRotatingDots(
                color: labelColor ?? ColorTheme.white,
                size: 30,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefix != null) ...[
                    prefix!,
                    const SizedBox(width: 4),
                  ],
                  TitanText(
                    text: label,
                    typography: TitanTypography.buttonLarge,
                    color: labelColor,
                  ),
                  if (suffix != null) ...[
                    const SizedBox(width: 4),
                    suffix!,
                  ],
                ],
              ),
      ),
    );
}
