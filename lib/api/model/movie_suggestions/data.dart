import 'suggestion_movie.dart';

class Data {
  Data({this.movieCount, this.movies});

  Data.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(SuggestionMovie.fromJson(v));
      });
    }
  }

  int? movieCount;
  List<SuggestionMovie>? movies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
