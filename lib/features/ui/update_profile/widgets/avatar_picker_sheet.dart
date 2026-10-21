import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class AvatarPickerSheet extends StatelessWidget {
  final int selectedIndex;

  const AvatarPickerSheet({super.key, required this.selectedIndex});

  static const List<String> avatars = [
    AppImages.profileAvatar1ImagePath,
    AppImages.profileAvatar2ImagePath,
    AppImages.profileAvatar3ImagePath,
    AppImages.profileAvatar4ImagePath,
    AppImages.profileAvatar5ImagePath,
    AppImages.profileAvatar6ImagePath,
    AppImages.profileAvatar7ImagePath,
    AppImages.profileAvatar8ImagePath,
    AppImages.profileAvatar9ImagePath,
  ];
  
  static Future<int?> show(
      BuildContext context, {
        required int selectedIndex,
      }) {
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.transparentColor,
      builder: (context) => AvatarPickerSheet(selectedIndex: selectedIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double padding = SizeUtils.getWidth(context, 16);
    final BorderRadius radius = BorderRadius.circular(
      SizeUtils.getWidth(context, 16),
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: AppColors.darkGreyColor,
            borderRadius: radius,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: avatars.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: padding,
              mainAxisSpacing: padding,
            ),
            itemBuilder: (context, index) {
              final bool isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => Navigator.pop(context, index),
                child: Container(
                  padding: EdgeInsets.all(SizeUtils.getWidth(context, 4)),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.yellowColor.withValues(alpha: 0.4)
                        : AppColors.transparentColor,
                    borderRadius: radius,
                    border: Border.all(color: AppColors.yellowColor),
                  ),
                  child: Image.asset(avatars[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}