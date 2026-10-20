import 'package:dio/dio.dart';
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
        queryParameters: {'limit': limit, 'sort_by': sortBy, 'genre': ?genre},
      );
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
