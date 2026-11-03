import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/dio/dio_manager.dart';
import 'package:movie_application/features/ui/home/tabs/search_tab/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Timer? _debounce;
  String _query = '';
  int _requestId = 0;

  void onQueryChanged(String value) {
    final text = value.trim();
    if (text == _query) return;
    _query = text;
    _debounce?.cancel();

    if (text.isEmpty) {
      _requestId++;
      emit(SearchInitial());
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), search);
  }

  Future<void> search() async {
    final int requestId = ++_requestId;
    emit(SearchLoading());
    try {
      final response = await DioManager.getMovie(queryTerm: _query, limit: 20);
      if (isClosed || requestId != _requestId) return;
      emit(SearchSuccess(response.data?.movies ?? []));
    } on DioException catch (error) {
      if (isClosed || requestId != _requestId) return;
      emit(SearchError(_messageFor(error)));
    } catch (_) {
      if (isClosed || requestId != _requestId) return;
      emit(SearchError('Something went wrong, please try again'));
    }
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

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}