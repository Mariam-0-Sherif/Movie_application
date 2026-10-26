import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class StatChip extends StatelessWidget {
  final IconData icon;
  final String value;

  const StatChip({super.key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getHeight(context, 12)),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(SizeUtils.getWidth(context, 16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.yellowColor,
            size: SizeUtils.getWidth(context, 24),
          ),
          SizedBox(width: SizeUtils.getWidth(context, 8)),
          Text(value, style: AppStyles.bold20WhiteRoboto),
        ],
      ),
    );
  }
}