import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/model/movie_details/movie.dart';

import '../../repository/profile_repository.dart';
import 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final ProfileRepository _repository;

  StreamSubscription<List<Movie>>? _subscription;

  WatchlistCubit(this._repository) : super(WatchlistInitial()) {
    loadWatchlist();
  }

  void loadWatchlist() {
    emit(WatchlistLoading());

    _subscription?.cancel();

    _subscription = _repository.getWatchlist().listen(
          (movies) {
        if (isClosed) return;
        emit(WatchlistSuccess(movies));
      },
      onError: (error) {
        if (isClosed) return;
        emit(WatchlistError(error.toString()));
      },
    );
  }

  Future<void> toggleWatchlist(Movie movie) async {
    try {
      final movieId = movie.id;

      if (movieId == null) {
        throw Exception('Movie ID is missing');
      }

      final isSaved = await _repository.isInWatchlist(movieId);

      if (isSaved) {
        await _repository.removeFromWatchlist(movieId);
      } else {
        await _repository.addToWatchlist(movie);
      }
    } catch (error) {
      if (isClosed) return;
      emit(WatchlistError(error.toString()));
    }
  }

  bool isSaved(int movieId) {
    if (state is! WatchlistSuccess) return false;

    final movies = (state as WatchlistSuccess).movies;

    return movies.any((movie) => movie.id == movieId);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
