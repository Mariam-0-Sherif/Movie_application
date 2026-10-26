import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class ScreenshotsSection extends StatelessWidget {
  final List<String> imageUrls;

  const ScreenshotsSection({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Screen Shots', style: AppStyles.bold24WhiteRoboto),
        for (final url in imageUrls) ...[
          SizedBox(height: SizeUtils.getHeight(context, 16)),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              SizeUtils.getWidth(context, 16),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(color: AppColors.darkGreyColor);
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}