import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_routes.dart';
import 'package:movie_application/core/utils/size_utils.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widget/custom_image_asset.dart';
import '../../../../../common/widget/app_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrayColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: SizeUtils.getHeight(context, 35),
          left: SizeUtils.getWidth(context, 16),
          right: SizeUtils.getWidth(context, 16),
          bottom: SizeUtils.getHeight(context, 16),
        ),
        child: Column(
          spacing: SizeUtils.getHeight(context, 30),
          children: [
            Row(
              spacing: SizeUtils.getWidth(context, 12),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildColumn(
                  context: context,
                  flex: 3,
                  children: [
                    ClipOval(
                      child: CustomImageAsset(
                        path: AppImages.profileAvatar8ImagePath,
                        width: SizeUtils.getWidth(context, 130),
                        height: SizeUtils.getWidth(context, 130),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text('John Safwat', style: AppStyles.bold20WhiteRoboto),
                  ],
                ),
                buildColumn(
                  context: context,
                  flex: 2,
                  children: [
                    Text('12', style: AppStyles.bold24WhiteRoboto),
                    Text('Watch List', style: AppStyles.bold20WhiteRoboto),
                  ],
                ),
                buildColumn(
                  context: context,
                  flex: 2,
                  children: [
                    Text('10', style: AppStyles.bold24WhiteRoboto),
                    Text('History', style: AppStyles.bold20WhiteRoboto),
                  ],
                ),
              ],
            ),
            Row(
              spacing: SizeUtils.getWidth(context, 12),
              children: [
                Expanded(
                  flex: 2,
                  child: AppButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.updateProfileRouteName,
                      );
                    },
                    child: Text(
                      'Edit Profile',
                      style: AppStyles.regular20BlackRoboto,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppButton(
                    onPressed: () {},
                    backgroundColor: AppColors.redColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: SizeUtils.getWidth(context, 12),
                      children: [
                        Text('Exit', style: AppStyles.regular20WhiteRoboto),
                        CustomImageAsset(path: AppImages.exitIconImagePath),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColumn({
    required List<Widget> children,
    required BuildContext context,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Column(
        spacing: SizeUtils.getHeight(context, 12),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
