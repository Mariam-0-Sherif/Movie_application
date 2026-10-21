import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/rating_badge.dart';


class MoviePosterCard extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final double width;
  final VoidCallback? onTap;

  const MoviePosterCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(SizeUtils.getWidth(context, 16));

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: SizeUtils.getWidth(context, width),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: ClipRRect(
            borderRadius: radius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const ColoredBox(color: AppColors.darkGreyColor);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(
                      color: AppColors.darkGreyColor,
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.lightGrayColor,
                      ),
                    );
                  },
                ),
                Positioned(
                  top: SizeUtils.getHeight(context, 8),
                  left: SizeUtils.getWidth(context, 8),
                  child: RatingBadge(rating: rating),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}