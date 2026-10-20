import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_image_asset.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

Widget buildField({
  required String hint,
  required Widget? prefixIcon,
  Widget? suffixIcon,
  required TextEditingController? controller,
  required OnValidator validator,
  bool? obscureText,
  TextInputType? keyboardType,
}) {
  return CustomTextFormField(
    controller: controller,
    filled: true,
    fillColor: AppColors.darkGreyColor,
    borderSideColor: AppColors.darkGreyColor,
    cursorColor: AppColors.whiteColor,
    style: AppStyles.regular16WhiteRoboto,
    hintText: hint,
    hintStyle: AppStyles.regular16WhiteRoboto,
    prefixIcon: CustomImageAsset(path: AppImages.emailIconImagePath),
    suffixIcon: suffixIcon,
    validator: validator,
    obscureText: obscureText,
    keyboardType: keyboardType,
  );
}

Widget buildElevatedButton({
  required VoidCallback? onPressed,
  required Widget? child,
  required BuildContext context,
}) {
  return CustomElevatedButton(
    onPressed: onPressed,
    backgroundColor: AppColors.yellowColor,
    radius: SizeUtils.getWidth(context, 15),
    padding: EdgeInsets.symmetric(vertical: SizeUtils.getHeight(context, 12)),
    child: child,
  );
}
