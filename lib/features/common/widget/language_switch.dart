import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class LanguageSwitch extends StatelessWidget {
  final VoidCallback? onTap;

  const LanguageSwitch({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        AppImages.languageSwitchIconImagePath,
        width: SizeUtils.getWidth(context, 91),
        height: SizeUtils.getHeight(context, 38),
        fit: BoxFit.contain,
      ),
    );
  }
}
