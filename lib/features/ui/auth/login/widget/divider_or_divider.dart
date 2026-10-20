import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';

import '../../../../../core/utils/size_utils.dart';
import '../../../../../core/widgets/divider_item.dart';

class DividerOrDivider extends StatelessWidget {
  const DividerOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DividerItem(
          color: AppColors.yellowColor,
          indent: SizeUtils.getWidth(context, 40),
          endIndent: SizeUtils.getWidth(context, 40),
        ),
        Text('OR', style: AppStyles.regular15YellowRoboto),
        DividerItem(
          color: AppColors.yellowColor,
          indent: SizeUtils.getWidth(context, 40),
          endIndent: SizeUtils.getWidth(context, 40),
        ),
      ],
    );
  }
}
