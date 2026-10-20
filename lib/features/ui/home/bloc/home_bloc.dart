/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/home/bloc/home_event.dart';
import 'package:movie_application/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository moviesRepository;

  HomeBloc({required this.moviesRepository}) : super(HomeInitial()) {
    on<GetPopularMoviesEvent>((event, emit) async {
      emit(HomeLoading());

      try {
        final movies = await moviesRepository.getPopularMovies();

        emit(HomeSuccess(movies));
      } catch (e) {
        emit(HomeError('Failed to fetch movies: $e'));
      }
    });
  }
}
*/
