import 'package:dio/dio.dart';
import 'package:movie_application/api/model/movie_details/movie_details_response.dart';
import 'package:movie_application/api/model/movie_suggestions/movie_suggestion_response.dart';
import 'package:movie_application/api/model/movies/movie_response.dart';

import '../model/api_constant.dart';

class DioManager {
  static final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  //https://movies-api.accel.li/api/v2/list_movies.json?quality=3D
  static Future<MovieResponse> getMovie({
    String? genre,
    int limit = 10,
    String sortBy = 'date_added',
  }) async {
    try {
      var response = await dio.get(
        ApiConstants.listMovies,
        queryParameters: {
          'limit': limit,
          'sort_by': sortBy,
          'genre': ?genre},
      );
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // https://movies-api.accel.li/api/v2/movie_details.json?movie_id=15&with_images=true&with_cast=true
  static Future<MovieDetailsResponse> getMovieDetails(String movieId, {
    bool withImage = true,
    bool withCast = true
  }) async {
    try {
      var response = await dio.get(
        ApiConstants.moviesDetails,
        queryParameters: {
          'movie_id': movieId,
          'with_images': withImage,
          'with_cast': withCast
        },
      );
      return MovieDetailsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  //https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_id=10
  static Future<MovieSuggestionResponse> getMovieSuggestions(
      String movieId) async {
    try {
      var response = await dio.get(
        ApiConstants.moviesSuggestions,
        queryParameters: {
          'movie_id': movieId,
        },
      );
      return MovieSuggestionResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
