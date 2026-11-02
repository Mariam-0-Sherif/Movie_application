import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/dio/dio_manager.dart';
import 'package:movie_application/api/model/movies/movies.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  static const String _actionGenre = 'Action';

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      final responses = await Future.wait([
        DioManager.getMovie(limit: 5, sortBy: 'download_count'),
        DioManager.getMovie(
          genre: _actionGenre,
          limit: 10,
          sortBy: 'download_count',
        ),
      ]);
      if (isClosed) return;
      emit(
        HomeSuccess(
          featured: _withPoster(responses[0].data?.movies),
          action: _withPoster(responses[1].data?.movies),
        ),
      );
    } on DioException catch (error) {
      if (isClosed) return;
      emit(HomeError(_messageFor(error)));
    } catch (_) {
      if (isClosed) return;
      emit(HomeError('Something went wrong, please try again'));
    }
  }

  List<Movies> _withPoster(List<Movies>? movies) {
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