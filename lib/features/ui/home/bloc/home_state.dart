import 'package:movie_application/api/model/movies/movies.dart';

sealed class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Movies> featured;
  final List<Movies> action;

  HomeSuccess({required this.featured, required this.action});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}