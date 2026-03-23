import 'package:move_on/features/library/data/datasources/library_local_data_source.dart';
import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/library/domain/repositories/library_repository.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  const LibraryRepositoryImpl(this._localDataSource);

  final LibraryLocalDataSource _localDataSource;

  @override
  Future<void> deleteReview(int mediaId) async {
    final reviews = await _localDataSource.getReviews();
    final updated = reviews
        .where((review) => review.mediaId != mediaId)
        .toList();
    await _localDataSource.saveReviews(updated);
  }

  @override
  Future<List<MediaItem>> getFavorites() {
    return _localDataSource.getFavorites();
  }

  @override
  Future<Review?> getReviewForMedia(int mediaId) async {
    final reviews = await _localDataSource.getReviews();

    for (final review in reviews) {
      if (review.mediaId == mediaId) {
        return review;
      }
    }

    return null;
  }

  @override
  Future<List<Review>> getReviews() async {
    final reviews = await _localDataSource.getReviews();
    reviews.sort((left, right) => right.updatedAt.compareTo(left.updatedAt));
    return reviews;
  }

  @override
  Future<bool> isFavorite(int mediaId) async {
    final favorites = await _localDataSource.getFavorites();
    return favorites.any((favorite) => favorite.id == mediaId);
  }

  @override
  Future<void> removeFavorite(int mediaId) async {
    final favorites = await _localDataSource.getFavorites();
    final updated = favorites
        .where((favorite) => favorite.id != mediaId)
        .toList();
    await _localDataSource.saveFavorites(updated);
  }

  @override
  Future<void> saveFavorite(MediaItem media) async {
    final favorites = await _localDataSource.getFavorites();
    final alreadySaved = favorites.any((favorite) => favorite.id == media.id);

    if (alreadySaved) {
      return;
    }

    await _localDataSource.saveFavorites([...favorites, media]);
  }

  @override
  Future<void> saveReview(Review review) async {
    final reviews = await _localDataSource.getReviews();
    final updated = reviews
        .where((item) => item.mediaId != review.mediaId)
        .toList();
    updated.add(review);
    await _localDataSource.saveReviews(updated);
  }
}
