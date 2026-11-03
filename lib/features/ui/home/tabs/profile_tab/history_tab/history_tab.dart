
import 'package:flutter/material.dart';
import 'package:movie_application/api/model/movie_details/movie.dart';
import 'package:movie_application/features/ui/home/tabs/profile_tab/repository/profile_repository.dart';
import 'package:movie_application/features/common/widget/movie_poster_card.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  late final ProfileRepository _repository;
  late final Stream<List<Movie>> _historyStream;

  @override
  void initState() {
    super.initState();
    _repository = ProfileRepository();
    _historyStream = _repository.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: _historyStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return const Center(
            child: Text(
              'Your History Is Empty',
              style: TextStyle(color: Colors.white),
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
