import '../../../../../../../api/model/movie_details/movie.dart';

sealed class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<Movie> movies;

  HistorySuccess(this.movies);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
