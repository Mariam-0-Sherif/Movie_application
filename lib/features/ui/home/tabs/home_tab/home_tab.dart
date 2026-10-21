import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/movie_poster_card.dart';

import '../../home_mock_data.dart';
import '../../widgets/genre_section.dart';
import '../../widgets/home_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.blackColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHeader(movies: mockMovies),
            GenreSection(
              title: 'Action',
              itemCount: mockMovies.length,
              itemBuilder: (context, index) {
                final movie = mockMovies[index];
                return MoviePosterCard(
                  imageUrl: movie.imageUrl,
                  rating: movie.rating,
                  width: 146,
                );
              },
            ),
            SizedBox(height: SizeUtils.getHeight(context, 120)),
          ],
        ),
      ),
    );
  }
}
