import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
      final featuredResponse = await _safeCall(
        'FEATURED',
        () => DioManager.getMovie(limit: 5, sortBy: 'download_count'),
      );
      final actionResponse = await _safeCall(
        'ACTION',
        () => DioManager.getMovie(
          genre: _actionGenre,
          limit: 10,
          sortBy: 'download_count',
        ),
      );

      if (isClosed) return;

      emit(
        HomeSuccess(
          featured: _withPoster(featuredResponse.data?.movies),
          action: _withPoster(actionResponse.data?.movies),
        ),
      );
    } on DioException catch (error) {
      debugPrint('DIO ERROR TYPE: ${error.type}');
      debugPrint('DIO STATUS: ${error.response?.statusCode}');
      debugPrint('DIO DATA: ${error.response?.data}');
      debugPrint('DIO MESSAGE: ${error.message}');
      if (isClosed) return;
      emit(HomeError(_messageFor(error)));
    } catch (e, stackTrace) {
      debugPrint('UNKNOWN ERROR: $e');
      debugPrint('STACK TRACE: $stackTrace');
      if (isClosed) return;
      emit(HomeError('Something went wrong, please try again'));
    }
  }

  Future<T> _safeCall<T>(String name, Future<T> Function() call) async {
    try {
      return await call();
    } catch (e, st) {
      debugPrint('>>> REQUEST "$name" FAILED: $e');
      debugPrint('>>> $st');
      rethrow;
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
      case DioExceptionType.badResponse:
        return 'Server error (${error.response?.statusCode}), please try again';
      default:
        return 'Something went wrong, please try again';
    }
  }
}