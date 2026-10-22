import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/model/movies/movies.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/movie_poster_card.dart';
import 'package:movie_application/features/ui/home/widgets/genre_section.dart';
import 'package:movie_application/features/ui/home/widgets/home_header.dart';
import 'package:movie_application/features/ui/home/widgets/movies_carousel.dart';
import 'package:movie_application/features/ui/widget/main_error_widget.dart';
import 'package:movie_application/features/ui/widget/main_loading_widget.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHome(),
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.blackColor,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeLoading() => const MainLoadingWidget(),
            HomeError(:final message) => Center(
              child: SingleChildScrollView(
                child: MainErrorWidget(
                  errorMessage: message,
                  onPressed: () => context.read<HomeCubit>().loadHome(),
                ),
              ),
            ),
            HomeSuccess(:final featured, :final action) => _buildContent(
              context,
              featured,
              action,
            ),
          };
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      List<Movies> featured,
      List<Movies> action,
      ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeader(movies: featured.map(_toCarouselMovie).toList()),
          GenreSection(
            title: 'Action',
            itemCount: action.length,
            itemBuilder: (context, index) {
              final movie = action[index];
              return MoviePosterCard(
                imageUrl: movie.mediumCoverImage ?? '',
                rating: movie.rating ?? 0.0,
                width: 146,
              );
            },
          ),
          SizedBox(height: SizeUtils.getHeight(context, 120)),
        ],
      ),
    );
  }

  CarouselMovie _toCarouselMovie(Movies movie) {
    return (
    imageUrl: movie.largeCoverImage ?? movie.mediumCoverImage ?? '',
    rating: movie.rating ?? 0.0,
    );
  }
}