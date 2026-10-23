import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.getWidth(context, 8),
        vertical: SizeUtils.getHeight(context, 4),
      ),
      decoration: BoxDecoration(
        color: AppColors.blackColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(SizeUtils.getWidth(context, 8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: AppStyles.regular16WhiteRoboto,
          ),
          SizedBox(width: SizeUtils.getWidth(context, 4)),
          Icon(
            Icons.star_rounded,
            color: AppColors.yellowColor,
            size: SizeUtils.getWidth(context, 18),
          ),
        ],
      ),
    );
  }
}