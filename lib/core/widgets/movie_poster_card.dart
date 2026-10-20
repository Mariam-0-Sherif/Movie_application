import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/size_utils.dart';

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
    // el poster tolo 1.5 darb el 3ard
    double height = width * 1.5;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeUtils.getWidth(context, 16)),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              // soret el film, lw el net we7esh btezhar khalfeya ramadeya
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(color: AppColors.darkGreyColor);
                  },
                ),
              ),

              // el rating fo2 el shemal (7.7 w nagma)
              Positioned(
                top: SizeUtils.getHeight(context, 8),
                left: SizeUtils.getWidth(context, 8),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.getWidth(context, 8),
                    vertical: SizeUtils.getHeight(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(
                      SizeUtils.getWidth(context, 8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: SizeUtils.getWidth(context, 14),
                        ),
                      ),
                      SizedBox(width: SizeUtils.getWidth(context, 4)),
                      Icon(
                        Icons.star,
                        color: AppColors.yellowColor,
                        size: SizeUtils.getWidth(context, 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
