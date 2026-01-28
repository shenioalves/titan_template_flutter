import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../legacy/color_theme.dart';

class TitanOtpField extends StatefulWidget {
  final int length;
  final double size;
  final double spacing;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const TitanOtpField({
    super.key,
    this.length = 4,
    this.size = 64,
    this.spacing = 7,
    required this.onCompleted,
    this.onChanged,
    this.controller,
  });

  @override
  State<TitanOtpField> createState() => _TitanOtpFieldState();
}

class _TitanOtpFieldState extends State<TitanOtpField> {
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _textControllers;
  late final TextEditingController _mainController;

  @override
  void initState() {
    super.initState();
    _mainController = widget.controller ?? TextEditingController();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _textControllers =
        List.generate(widget.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    if (widget.controller == null) {
      _mainController.dispose();
    }
    super.dispose();
  }

  void _onInputChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _updateMainController();
  }

  void _updateMainController() {
    final otp = _textControllers.map((c) => c.text).join();
    _mainController.text = otp;
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) {
      _focusNodes.last.unfocus();
      widget.onCompleted(otp);
    }
  }

  Widget _buildOtpInput(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
       gradient: ColorTheme.otpGradient,
      ),
      width: widget.size,
      height: widget.size,
      child: TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        textAlignVertical: TextAlignVertical.center,
   
        controller: _textControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.transparent,
               contentPadding: EdgeInsets.zero,    
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(color: ColorTheme.dark_2, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
          ),
        ),
        onChanged: (value) => _onInputChanged(value, index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: widget.spacing,
      children: List.generate(
        widget.length,
        (index) => _buildOtpInput(index),
      ),
    );
  }
}
