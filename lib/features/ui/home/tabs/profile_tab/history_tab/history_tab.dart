import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/features/common/widget/movie_poster_card.dart';

import '../../../../../../core/utils/app_styles.dart';
import 'cubit/history_cubit.dart';
import 'cubit/history_state.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is HistoryInitial || state is HistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HistoryError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: AppStyles.regular20WhiteRoboto,
            ),
          );
        }
        final movies = (state as HistorySuccess).movies;

        if (movies.isEmpty) {
          return Center(
            child: Text(
              'Your History Is Empty',
              style: AppStyles.regular20WhiteRoboto,
            ),
          );
        }

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
      },
    );
  }
}