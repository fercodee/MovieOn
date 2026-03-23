import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:move_on/features/library/data/models/review_model.dart';
import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/shared/data/models/media_item_model.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

abstract class LibraryLocalDataSource {
  Future<List<MediaItem>> getFavorites();

  Future<void> saveFavorites(List<MediaItem> favorites);

  Future<List<Review>> getReviews();

  Future<void> saveReviews(List<Review> reviews);
}

class LibraryLocalDataSourceImpl implements LibraryLocalDataSource {
  const LibraryLocalDataSourceImpl(this._preferences);

  static const _favoritesKey = 'movie_on_favorites';
  static const _reviewsKey = 'movie_on_reviews';

  final SharedPreferences _preferences;

  @override
  Future<List<MediaItem>> getFavorites() async {
    final raw = _preferences.getString(_favoritesKey);
    if (raw == null || raw.isEmpty) {
      return <MediaItem>[];
    }

    final data = jsonDecode(raw) as List<dynamic>;
    return data
        .whereType<Map<String, dynamic>>()
        .map(MediaItemModel.fromLocalMap)
        .toList();
  }

  @override
  Future<void> saveFavorites(List<MediaItem> favorites) {
    final json = jsonEncode(
      favorites
          .map(MediaItemModel.fromEntity)
          .map((item) => item.toLocalMap())
          .toList(),
    );

    return _preferences.setString(_favoritesKey, json);
  }

  @override
  Future<List<Review>> getReviews() async {
    final raw = _preferences.getString(_reviewsKey);
    if (raw == null || raw.isEmpty) {
      return <Review>[];
    }

    final data = jsonDecode(raw) as List<dynamic>;
    return data
        .whereType<Map<String, dynamic>>()
        .map(ReviewModel.fromMap)
        .toList();
  }

  @override
  Future<void> saveReviews(List<Review> reviews) {
    final json = jsonEncode(
      reviews
          .map(ReviewModel.fromEntity)
          .map((review) => review.toMap())
          .toList(),
    );

    return _preferences.setString(_reviewsKey, json);
  }
}
