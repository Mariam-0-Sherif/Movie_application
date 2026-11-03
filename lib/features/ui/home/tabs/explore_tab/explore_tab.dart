import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/model/movies/movies.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/features/common/utils/main_error_widget.dart';
import 'package:movie_application/features/common/utils/main_loading_widget.dart';
import 'package:movie_application/features/ui/home/tabs/explore_tab/cubit/browse_cubit.dart';
import 'package:movie_application/features/ui/home/tabs/explore_tab/cubit/browse_state.dart';
import 'package:movie_application/features/ui/home/tabs/explore_tab/widgets/genre_chips.dart';
import 'package:movie_application/features/ui/movie_details/movie_details_screen.dart';

import '../../../../common/widget/movie_poster_card.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrowseCubit()..loadMovies(),
      child: const _BrowseContent(),
    );
  }
}

class _BrowseContent extends StatelessWidget {
  const _BrowseContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: BlocBuilder<BrowseCubit, BrowseState>(
          builder: (context, state) {
            return switch (state) {
              BrowseLoading() => const MainLoadingWidget(),
              BrowseError(:final message) => Center(
                child: SingleChildScrollView(
                  child: MainErrorWidget(
                    errorMessage: message,
                    onPressed: () => context.read<BrowseCubit>().loadMovies(),
                  ),
                ),
              ),
              BrowseSuccess(
                  :final genres,
                  :final selectedGenre,
                  :final movies,
              ) =>
                  _buildContent(context, genres, selectedGenre, movies),
            };
          },
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      List<String> genres,
      String selectedGenre,
      List<Movies> movies,
      ) {
    final double spacing = SizeUtils.getWidth(context, 16);

    return Column(
      children: [
        SizedBox(height: SizeUtils.getHeight(context, 16)),
        GenreChips(
          genres: genres,
          selected: selectedGenre,
          onSelected: (genre) => context.read<BrowseCubit>().selectGenre(genre),
        ),
        SizedBox(height: SizeUtils.getHeight(context, 16)),
        Expanded(
          child: movies.isEmpty
              ? Center(
            child: Text(
              'No movies in this genre',
              style: AppStyles.regular16WhiteRoboto,
            ),
          )
              : GridView.builder(
            padding: EdgeInsets.fromLTRB(spacing, 0, spacing, spacing),
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
                imageUrl: movie.mediumCoverImage ?? '',
                rating: movie.rating ?? 0.0,
                width: 191,
                onTap: () {
                  final id = movie.id;
                  if (id == null) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailsScreen(movieId: id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}