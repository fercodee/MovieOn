import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

abstract class LibraryRepository {
  Future<List<MediaItem>> getFavorites();

  Future<bool> isFavorite(int mediaId);

  Future<void> saveFavorite(MediaItem media);

  Future<void> removeFavorite(int mediaId);

  Future<List<Review>> getReviews();

  Future<Review?> getReviewForMedia(int mediaId);

  Future<void> saveReview(Review review);

  Future<void> deleteReview(int mediaId);
}
