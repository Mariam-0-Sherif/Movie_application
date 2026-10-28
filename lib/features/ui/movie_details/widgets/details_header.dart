import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class DetailsHeader extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final VoidCallback? onBookmark;
  final VoidCallback? onPlay;

  const DetailsHeader({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.year,
    this.onBookmark,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeUtils.getHeight(context, 620),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const ColoredBox(color: AppColors.darkGreyColor);
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blackColor.withValues(alpha: 0.55),
                  AppColors.transparentColor,
                  AppColors.blackColor.withValues(alpha: 0.75),
                  AppColors.blackColor,
                ],
                stops: const [0, 0.35, 0.75, 1],
              ),
            ),
          ),
          _buildTopBar(context),
          Align(
            alignment: const Alignment(0, -0.2),
            child: GestureDetector(
              onTap: onPlay,
              child: Icon(
                Icons.play_circle_outline_rounded,
                color: AppColors.yellowColor,
                size: SizeUtils.getWidth(context, 96),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.getWidth(context, 16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppStyles.bold20WhiteRoboto,
                  ),
                  SizedBox(height: SizeUtils.getHeight(context, 12)),
                  Text(year, style: AppStyles.regular16WhiteRoboto),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.getWidth(context, 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.whiteColor,
                ),
              ),
              IconButton(
                onPressed: onBookmark,
                icon: const Icon(Icons.bookmark, color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}