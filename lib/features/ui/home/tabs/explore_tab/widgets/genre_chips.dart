import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class GenreChips extends StatelessWidget {
  final List<String> genres;
  final String selected;
  final ValueChanged<String> onSelected;

  const GenreChips({
    super.key,
    required this.genres,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(SizeUtils.getWidth(context, 16));

    return SizedBox(
      height: SizeUtils.getHeight(context, 44),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: SizeUtils.getWidth(context, 16),
        ),
        itemCount: genres.length,
        separatorBuilder: (context, index) {
          return SizedBox(width: SizeUtils.getWidth(context, 10));
        },
        itemBuilder: (context, index) {
          final genre = genres[index];
          final isSelected = genre == selected;
          return GestureDetector(
            onTap: () => onSelected(genre),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.getWidth(context, 16),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.yellowColor
                    : AppColors.transparentColor,
                borderRadius: radius,
                border: Border.all(color: AppColors.yellowColor, width: 2),
              ),
              child: Text(
                genre,
                style: isSelected
                    ? AppStyles.bold20BlackInter
                    : AppStyles.bold20YellowInter,
              ),
            ),
          );
        },
      ),
    );
  }
}