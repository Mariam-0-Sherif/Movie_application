import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

typedef OnChanged = ValueChanged<String>?;
typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? borderSideColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? style;
  final Color? cursorColor;
  final TextEditingController? controller;
  final OnChanged onChanged;
  final OnValidator validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLines;
  final String? obscuringCharacter;
  final Color? fillColor;
  final bool? filled;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.borderSideColor,
    this.suffixIcon,
    this.prefixIcon,
    this.style,
    this.cursorColor,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.obscuringCharacter,
    this.fillColor,
    this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      cursorColor: cursorColor,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      obscuringCharacter: obscuringCharacter ?? '*',
      decoration: InputDecoration(
        enabledBorder: _buildDecorationInputBorder(
          borderSideColor: borderSideColor ?? Theme.of(context).dividerColor,
        ),
        focusedBorder: _buildDecorationInputBorder(
          borderSideColor: borderSideColor ?? Theme.of(context).dividerColor,
        ),
        errorBorder: _buildDecorationInputBorder(
          borderSideColor: AppColors.redColor,
        ),
        focusedErrorBorder: _buildDecorationInputBorder(
          borderSideColor: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: filled ?? false,
      ),
    );
  }

  OutlineInputBorder _buildDecorationInputBorder({
    required Color borderSideColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 2, color: borderSideColor),
    );
  }
}
