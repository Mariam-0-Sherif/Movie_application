import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class GenreSection extends StatelessWidget {
  final String title;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback? onSeeMore;

  /// Height of a poster card in Figma (146 wide with a 2:3 ratio).
  static const double _listHeight = 219;

  const GenreSection({
    super.key,
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = SizeUtils.getWidth(context, 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppStyles.regular20WhiteRoboto),
              GestureDetector(
                onTap: onSeeMore,
                child: Row(
                  children: [
                    Text('See More', style: AppStyles.regular16YellowRoboto),
                    SizedBox(width: SizeUtils.getWidth(context, 6)),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.yellowColor,
                      size: SizeUtils.getWidth(context, 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SizeUtils.getHeight(context, 12)),
        SizedBox(
          height: SizeUtils.getHeight(context, _listHeight),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            itemCount: itemCount,
            separatorBuilder: (context, index) {
              return SizedBox(width: SizeUtils.getWidth(context, 16));
            },
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}
