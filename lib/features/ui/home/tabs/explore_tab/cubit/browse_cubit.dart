import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/dio/dio_manager.dart';
import 'package:movie_application/api/model/movies/movies.dart';
import 'package:movie_application/features/ui/home/tabs/explore_tab/cubit/browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseLoading());

  List<Movies> _allMovies = [];
  List<String> _genres = [];

  Future<void> loadMovies() async {
    emit(BrowseLoading());
    try {
      final response = await DioManager.getMovie(
        limit: 50,
        sortBy: 'download_count',
      );
      if (isClosed) return;

      _allMovies = (response.data?.movies ?? [])
          .where((movie) => (movie.mediumCoverImage ?? '').isNotEmpty)
          .toList();

      // A Set keeps every genre once, no matter how many movies have it.
      final genres = <String>{};
      for (final movie in _allMovies) {
        genres.addAll(movie.genres ?? []);
      }
      _genres = genres.toList()..sort();

      selectGenre(_genres.isEmpty ? '' : _genres.first);
    } on DioException catch (error) {
      if (isClosed) return;
      emit(BrowseError(_messageFor(error)));
    } catch (_) {
      if (isClosed) return;
      emit(BrowseError('Something went wrong, please try again'));
    }
  }

  void selectGenre(String genre) {
    final movies = genre.isEmpty
        ? _allMovies
        : _allMovies
        .where((movie) => (movie.genres ?? []).contains(genre))
        .toList();
    emit(
      BrowseSuccess(genres: _genres, selectedGenre: genre, movies: movies),
    );
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