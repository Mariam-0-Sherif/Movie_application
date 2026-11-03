
import 'package:movie_application/api/model/movie_details/movie.dart';

sealed class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistSuccess extends WatchlistState {
  final List<Movie> movies;

  WatchlistSuccess(this.movies);
}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);
}
