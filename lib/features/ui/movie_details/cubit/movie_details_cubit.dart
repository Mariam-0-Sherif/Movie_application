import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/dio/dio_manager.dart';

import '../../../../api/model/movie_suggestions/suggestion_movie.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsLoading());

  Future<void> loadMovie(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final detailsFuture = DioManager.getMovieDetails(movieId.toString());
      final suggestionsFuture = _loadSuggestions(movieId);
      final detailsResponse = await detailsFuture;
      final suggestions = await suggestionsFuture;
      if (isClosed) return;

      final movie = detailsResponse.data?.movie;
      if (movie == null) {
        emit(MovieDetailsError('Movie not found'));
        return;
      }

      emit(MovieDetailsSuccess(movie: movie, suggestions: suggestions));
    } on DioException catch (error) {
      if (isClosed) return;
      emit(MovieDetailsError(_messageFor(error)));
    } catch (_) {
      if (isClosed) return;
      emit(MovieDetailsError('Something went wrong, please try again'));
    }
  }

  Future<List<SuggestionMovie>> _loadSuggestions(int movieId) async {
    try {
      final response = await DioManager.getMovieSuggestions(movieId.toString());
      return _withPoster(response.data?.movies);
    } catch (_) {
      return [];
    }
  }

  List<SuggestionMovie> _withPoster(List<SuggestionMovie>? movies) {
    return (movies ?? [])
        .where((movie) => (movie.mediumCoverImage ?? '').isNotEmpty)
        .toList();
  }

  String _messageFor(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The connection timed out, please try again';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Something went wrong, please try again';
    }
  }
}
