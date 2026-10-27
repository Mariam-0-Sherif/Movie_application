import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/model/movie_details/movie.dart';
import 'package:movie_application/api/model/movie_suggestions/suggestion_movie.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/features/common/utils/main_error_widget.dart';
import 'package:movie_application/features/common/utils/main_loading_widget.dart';
import 'package:movie_application/features/ui/movie_details/widgets/cast_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/details_header.dart';
import 'package:movie_application/features/ui/movie_details/widgets/genres_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/movie_stats_row.dart';
import 'package:movie_application/features/ui/movie_details/widgets/screenshots_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/similar_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/summary_section.dart';

import '../../common/widget/app_button.dart';
import 'cubit/movie_details_cubit.dart';
import 'cubit/movie_details_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      MovieDetailsCubit()
        ..loadMovie(movieId),
      child: _DetailsContent(movieId: movieId),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  final int movieId;

  const _DetailsContent({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          return switch (state) {
            MovieDetailsLoading() => const MainLoadingWidget(),
            MovieDetailsError(:final message) =>
                SafeArea(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      Center(
                        child: SingleChildScrollView(
                          child: MainErrorWidget(
                            errorMessage: message,
                            onPressed: () =>
                                context
                                    .read<MovieDetailsCubit>()
                                    .loadMovie(movieId),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            MovieDetailsSuccess(:final movie, :final suggestions) =>
                _buildContent(context, movie, suggestions),
          };
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context,
      Movie movie,
      List<SuggestionMovie> suggestions,) {
    final sectionGap = SizedBox(height: SizeUtils.getHeight(context, 24));

    final screenshots = [
      movie.largeScreenshotImage1,
      movie.largeScreenshotImage2,
      movie.largeScreenshotImage3,
    ].whereType<String>().where((url) => url.isNotEmpty).toList();

    final cast = (movie.cast ?? [])
        .map((c) =>
    (
    name: c.name ?? '',
    character: c.characterName ?? '',
    imageUrl: c.urlSmallImage ?? '',
    )).toList();

    final similar = suggestions
        .map((m) =>
    (
    id: m.id ?? 0,
    imageUrl: m.mediumCoverImage ?? '',
    rating: (m.rating ?? 0).toDouble(),
    )).toList();

    final summary = (movie.descriptionFull?.isNotEmpty ?? false)
        ? movie.descriptionFull!
        : (movie.descriptionIntro ?? '');

    final genres = movie.genres ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          DetailsHeader(
            imageUrl: movie.largeCoverImage ?? '',
            title: movie.title ?? '',
            year: '${movie.year ?? ''}',
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.getWidth(context, 16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: SizeUtils.getHeight(context, 16)),
                AppButton(
                  onPressed: () {},
                  backgroundColor: AppColors.redColor,
                  child: Text('Watch', style: AppStyles.regular20WhiteRoboto),
                ),
                SizedBox(height: SizeUtils.getHeight(context, 16)),
                MovieStatsRow(
                  likes: movie.likeCount ?? 0,
                  runtime: movie.runtime ?? 0,
                  rating: (movie.rating ?? 0).toDouble(),
                ),
                if (screenshots.isNotEmpty) ...[
                  sectionGap,
                  ScreenshotsSection(imageUrls: screenshots),
                ],
                if (similar.isNotEmpty) ...[
                  sectionGap,
                  SimilarSection(
                    movies: similar,
                    onMovieTap: (index) {
                      final id = suggestions[index].id;
                      if (id == null) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>
                            MovieDetailsScreen(movieId: id)),
                      );
                    },
                  ),
                ],
                if (summary.isNotEmpty) ...[
                  sectionGap,
                  SummarySection(summary: summary),
                ],
                if (cast.isNotEmpty) ...[
                  sectionGap,
                  CastSection(cast: cast),
                ],
                if (genres.isNotEmpty) ...[
                  sectionGap,
                  GenresSection(genres: genres),
                ],
                SizedBox(height: SizeUtils.getHeight(context, 32)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}