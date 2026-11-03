
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_application/api/model/movie_details/movie.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _watchlist =>
      _firestore.collection('users').doc(_uid).collection('watchlist');

  CollectionReference<Map<String, dynamic>> get _history =>
      _firestore.collection('users').doc(_uid).collection('history');

  Map<String, dynamic> _movieData(Movie movie) {
    return {
      'id': movie.id,
      'title': movie.title,
      'title_english': movie.titleEnglish,
      'year': movie.year,
      'rating': movie.rating,
      'runtime': movie.runtime,
      'genres': movie.genres ?? [],
      'medium_cover_image': movie.mediumCoverImage,
      'large_cover_image': movie.largeCoverImage,
      'background_image': movie.backgroundImage,
    };
  }

  // Watchlist

  Future<void> addToWatchlist(Movie movie) async {
    if (movie.id == null) {
      throw Exception('Movie ID is missing');
    }

    await _watchlist.doc(movie.id.toString()).set({
      ..._movieData(movie),
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFromWatchlist(int movieId) async {
    await _watchlist.doc(movieId.toString()).delete();
  }

  Future<bool> isInWatchlist(int movieId) async {
    final doc = await _watchlist.doc(movieId.toString()).get();
    return doc.exists;
  }

  Stream<List<Movie>> getWatchlist() {
    return _watchlist
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => Movie.fromJson(doc.data()))
          .toList(),
    );
  }

  // History

  Future<void> addToHistory(Movie movie) async {
    if (movie.id == null) {
      throw Exception('Movie ID is missing');
    }

    await _history.doc(movie.id.toString()).set({
      ..._movieData(movie),
      'visitedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Movie>> getHistory() {
    return _history
        .orderBy('visitedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => Movie.fromJson(doc.data()))
          .toList(),
    );
  }
}
