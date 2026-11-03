import 'package:movie_application/api/model/movies/movies.dart';

sealed class BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseSuccess extends BrowseState {
  final List<String> genres;
  final String selectedGenre;
  final List<Movies> movies;

  BrowseSuccess({
    required this.genres,
    required this.selectedGenre,
    required this.movies,
  });
}

class BrowseError extends BrowseState {
  final String message;

  BrowseError(this.message);
}