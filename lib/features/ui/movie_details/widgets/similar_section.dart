import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

import '../../../common/widget/movie_poster_card.dart';

typedef SimilarMovie = ({int id, String imageUrl, double rating});

class SimilarSection extends StatelessWidget {
  final List<SimilarMovie> movies;
  final ValueChanged<int>? onMovieTap;

  const SimilarSection({super.key, required this.movies, this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    final spacing = SizeUtils.getWidth(context, 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Similar', style: AppStyles.bold24WhiteRoboto),
        SizedBox(height: SizeUtils.getHeight(context, 16)),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MoviePosterCard(
              imageUrl: movie.imageUrl,
              rating: movie.rating,
              width: 191,
              onTap: () => onMovieTap?.call(index),
            );
          },
        ),
      ],
    );
  }
}