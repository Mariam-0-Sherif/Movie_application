import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import 'custom_text_form_field.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final OnValidator? validator;
  final bool? obscureText;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.validator,
    this.obscureText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      filled: true,
      fillColor: AppColors.darkGreyColor,
      borderSideColor: AppColors.darkGreyColor,
      cursorColor: AppColors.whiteColor,
      style: AppStyles.regular16WhiteRoboto,
      hintText: hint,
      hintStyle: AppStyles.regular16WhiteRoboto,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}
