import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/library/domain/repositories/library_repository.dart';

class SaveReviewUseCase {
  const SaveReviewUseCase(this._repository);

  final LibraryRepository _repository;

  Future<void> call(Review review) {
    return _repository.saveReview(review);
  }
}
