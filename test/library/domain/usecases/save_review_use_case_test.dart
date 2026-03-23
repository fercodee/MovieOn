import 'package:flutter_test/flutter_test.dart';

import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/library/domain/repositories/library_repository.dart';
import 'package:move_on/features/library/domain/usecases/save_review_use_case.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

void main() {
  test('deve persistir uma resenha no repositorio', () async {
    final repository = _FakeLibraryRepository();
    final review = Review(
      mediaId: 5,
      mediaType: MediaType.tv,
      mediaTitle: 'Ruptura',
      comment: 'Serie excelente e tensa.',
      rating: 4.5,
      updatedAt: DateTime(2026, 3, 22, 10),
    );

    final useCase = SaveReviewUseCase(repository);

    await useCase(review);

    expect(repository.savedReview, review);
  });
}

class _FakeLibraryRepository implements LibraryRepository {
  Review? savedReview;

  @override
  Future<void> deleteReview(int mediaId) async {}

  @override
  Future<List<MediaItem>> getFavorites() async => const [];

  @override
  Future<Review?> getReviewForMedia(int mediaId) async => null;

  @override
  Future<List<Review>> getReviews() async => const [];

  @override
  Future<bool> isFavorite(int mediaId) async => false;

  @override
  Future<void> removeFavorite(int mediaId) async {}

  @override
  Future<void> saveFavorite(MediaItem media) async {}

  @override
  Future<void> saveReview(Review review) async {
    savedReview = review;
  }
}
