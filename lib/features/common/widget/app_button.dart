import 'package:flutter/cupertino.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_utils.dart';
import 'custom_elevated_button.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? backgroundColor;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.yellowColor,
      radius: SizeUtils.getWidth(context, 15),
      padding: EdgeInsets.symmetric(
        vertical: SizeUtils.getHeight(context, 12),
        horizontal: SizeUtils.getWidth(context, 5),
      ),
      child: child,
    );
  }
}
