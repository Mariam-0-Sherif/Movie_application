import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/model/movie_details/movie.dart';

import '../../repository/profile_repository.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final ProfileRepository _repository;
  StreamSubscription<List<Movie>>? _subscription;

  HistoryCubit(this._repository) : super(HistoryInitial()) {
    loadHistory();
  }

  void loadHistory() {
    emit(HistoryLoading());
    _subscription?.cancel();
    _subscription = _repository.getHistory().listen(
      (movies) {
        if (isClosed) return;
        emit(HistorySuccess(movies));
      },
      onError: (e) {
        if (isClosed) return;
        emit(HistoryError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
