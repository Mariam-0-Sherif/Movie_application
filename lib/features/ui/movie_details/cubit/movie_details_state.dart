import 'package:movie_application/api/model/movie_suggestions/suggestion_movie.dart';

import '../../../../api/model/movie_details/movie.dart';

sealed class MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final Movie movie;
  final List<SuggestionMovie> suggestions;

  MovieDetailsSuccess({required this.movie, required this.suggestions});
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}
