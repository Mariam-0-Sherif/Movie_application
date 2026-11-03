import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_application/api/model/movie_details/movie.dart';

import '../model/profile_data.dart';

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

  DocumentReference<Map<String, dynamic>> get _userDoc =>
      _firestore.collection('users').doc(_uid);

  Future<ProfileData> getProfile() async {
    final doc = await _userDoc.get();
    final data = doc.data();

    if (data == null) {
      return ProfileData(
        name: _auth.currentUser?.displayName ?? ProfileData.initial.name,
        phone: ProfileData.initial.phone,
        avatarIndex: ProfileData.initial.avatarIndex,
      );
    }
    return ProfileData(
      name: data['name'] ?? ProfileData.initial.name,
      phone: data['phone'] ?? ProfileData.initial.phone,
      avatarIndex: ((data['avatarIndex'] ?? data['avatar']) as num?)?.toInt() ??
          ProfileData.initial.avatarIndex,
    );
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    await _userDoc.set({
      'name': name,
      'phone': phone,
      'avatarIndex': avatarIndex,
    }, SetOptions(merge: true));
    await _auth.currentUser?.updateDisplayName(name);
  }
}
