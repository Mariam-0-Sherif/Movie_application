import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/model/movie_details/movie.dart';
import 'package:movie_application/features/common/widget/movie_poster_card.dart';

import 'cubit/watchlist_cubit.dart';
import 'cubit/watchlist_state.dart';
class WatchTab extends StatelessWidget {
  const WatchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoading || state is WatchlistInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is WatchlistError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        if (state is WatchlistSuccess) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'Your Watch List Is Empty',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return _buildMoviesGrid(movies);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMoviesGrid(List<Movie> movies) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];

        return MoviePosterCard(
          imageUrl: movie.mediumCoverImage ?? '',
          rating: (movie.rating ?? 0).toDouble(),
          width: 191,
        );
      },
    );
  }
}
