import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class GenresSection extends StatelessWidget {
  final List<String> genres;

  const GenresSection({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Genres', style: AppStyles.bold24WhiteRoboto),
        SizedBox(height: SizeUtils.getHeight(context, 16)),
        Wrap(
          spacing: SizeUtils.getWidth(context, 16),
          runSpacing: SizeUtils.getHeight(context, 16),
          children: [
            for (final genre in genres)
              Container(
                width: SizeUtils.getWidth(context, 122),
                padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.getHeight(context, 10),
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.darkGreyColor,
                  borderRadius: BorderRadius.circular(
                    SizeUtils.getWidth(context, 8),
                  ),
                ),
                child: Text(genre, style: AppStyles.regular16WhiteRoboto),
              ),
          ],
        ),
      ],
    );
  }
}