import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';

import '../../utils/format_text_utils.dart';
import '../../utils/responsive_utils.dart';
import '../legacy/color_theme.dart';
import '../legacy/titan_typography.dart';
import 'titan_text.dart';

class TitanTextField extends StatefulWidget {
  final String? Function(String?)? validateInput;
  final void Function()? onSubmittedFun;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? label;
  final int? qtdLines;
  final int? qtdCaract;
  final String? texHint;
  final bool isPassword;
  final bool isCPF;
  final bool isDate;
  final bool isMonthYear;
  final bool isPhone;
  final bool isDeletMargin;
  final Color? colorLabel;
  final double? marginBotton;
  final double? marginTop;
  final FocusNode? focusNode;
  final void Function(String value, int index)? onChangedCodeFocus;
  final int? indexFocus;
  final bool? filled;
  final TextAlign? textAlign;
  final Widget? suffixIcon;
  final bool isEnabled;
  final bool lockedStyle;
  final bool isOptional;

  const TitanTextField({
    super.key,
    this.label,
    this.inputType,
    this.controller,
    this.isPassword = false,
    this.isCPF = false,
    this.isMonthYear = false,
    this.isDate = false,
    this.isPhone = false,
    this.qtdLines,
    this.texHint,
    this.validateInput,
    this.onSubmittedFun,
    this.qtdCaract,
    this.colorLabel,
    this.marginBotton,
    this.marginTop,
    this.isDeletMargin = false,
    this.focusNode,
    this.onChangedCodeFocus,
    this.indexFocus,
    this.filled = false,
    this.textAlign,
    this.suffixIcon,
    this.isEnabled = true,
    this.lockedStyle = false,
    this.isOptional = false,
  });

  @override
  State<TitanTextField> createState() => _TitanTextFieldState();
}

class _TitanTextFieldState extends State<TitanTextField> {
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  final ResponsiveUtils responsiveUtils = ResponsiveUtils();

  @override
  void dispose() {
    _obscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
        
    return Padding(
      padding: EdgeInsets.only(
          top: widget.marginTop ?? 0, bottom: widget.marginBotton ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label != null
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: responsiveUtils.getHeightSpacing(context, 5),
                  ),
                  child: TitanText(
                    text: widget.label!,
                    typography: TitanTypography.titleLarge,
                    color: widget.colorLabel ?? ColorTheme.gray_600,
                  ),
                )
              : const SizedBox.shrink(),
          ValueListenableBuilder(
            valueListenable: _obscureText,
            builder: (context, obscureText, child) {
              return SizedBox(
                child: TextFormField(
                  enabled: widget.isEnabled,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  focusNode: widget.focusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: baseStyle.copyWith(
                    fontSize: widget.isDeletMargin
                        ? TitanTypography.titleMdSemibold.size *
                            responsiveUtils.getTextScale(context)
                        : null,
                    color: widget.lockedStyle
                        ? ColorTheme.white
                        : ColorTheme.white,
                  ),
                  inputFormatters: widget.qtdCaract == null
                      ? null
                      : [
                          LengthLimitingTextInputFormatter(
                              widget.qtdCaract!),
                        ],
                  maxLines: widget.qtdLines ?? 1,
                  controller: widget.controller,
                  obscureText:
                      widget.isPassword ? _obscureText.value : false,
                  keyboardType: widget.inputType,
                  validator: (value) {
                    if (widget.isOptional &&
                        (value == null || value.isEmpty)) {
                      return null;
                    }
                    return widget.validateInput?.call(value);
                  },
                  onFieldSubmitted: (value) {
                    if (widget.onSubmittedFun != null) {
                      widget.onSubmittedFun!();
                    }
                  },
                  onChanged: (value) {
                    if (widget.onChangedCodeFocus != null) {
                      widget.onChangedCodeFocus!(value, widget.indexFocus!);
                    }

                    if (widget.isCPF) {
                      widget.controller!.text =
                          FormatTextUtils.formatCPF(value);
                    }

                    if (widget.isPhone) {
                      widget.controller!.text =
                          FormatTextUtils.formatPhone(value);

                      if (widget.controller!.text.length == 15) {
                        FocusScope.of(context).unfocus();
                      }
                    }

                    if (widget.isDate) {
                      widget.controller!.text =
                          FormatTextUtils.formatDateInput(value);

                      if (widget.controller!.text.length == 10) {
                        FocusScope.of(context).unfocus();
                      }
                    }

                    if (widget.isMonthYear) {
                      widget.controller!.text =
                          FormatTextUtils.formatDateMonthYearInput(value);

                      if (widget.controller!.text.length == 7) {
                        FocusScope.of(context).unfocus();
                      }
                    }
                  },
                  maxLength: widget.isCPF
                      ? 14
                      : widget.isDate
                          ? 10
                          : widget.isMonthYear
                              ? 7
                              : widget.isPhone
                                  ? 15
                                  : widget.onChangedCodeFocus != null
                                      ? 1
                                      : null,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.texHint,
                    hintStyle: baseStyle.copyWith(
                      color: ColorTheme.white.withValues(alpha: 0.3),
                      fontSize: widget.isDeletMargin
                          ? baseStyle.fontSize! *
                              responsiveUtils.getTextScale(context)
                          : null,
                    ),
                    errorMaxLines: 4,
                    counterText: "",
                    filled: widget.filled,
                    fillColor: widget.lockedStyle
                        ? ColorTheme.gray_100
                        : ColorTheme.white,
                    focusColor: ColorTheme.error_200,
                    errorStyle: TextStyle(
                      fontSize: 14 * responsiveUtils.getTextScale(context),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: responsiveUtils.getWidthSpacing(
                        context,
                        widget.isDeletMargin
                            ? 10
                            : widget.onChangedCodeFocus != null
                                ? 15
                                : 20,
                      ),
                      vertical: responsiveUtils.getHeightSpacing(
                        context,
                        widget.isDeletMargin ? 10 : 15,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.gray_2, width: 1),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: widget.lockedStyle
                          ? BorderSide.none
                          : BorderSide(color: ColorTheme.dark, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: ColorTheme.yellow, width: 2),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.dark, width: 1),
                    ),
                    suffixIcon: widget.suffixIcon ??
                        (widget.isPassword
                            ? GestureDetector(
                                onTap: () {
                                  _obscureText.value = !obscureText;
                                },
                                child: Icon(
                                  obscureText
                                      ? Remix.eye_close_line
                                      : Remix.eye_line,
                                  color: ColorTheme.gray_400,
                                  size: 28 *
                                      responsiveUtils
                                          .getImageScale(context),
                                ),
                              )
                            : null),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
      
  }
}
