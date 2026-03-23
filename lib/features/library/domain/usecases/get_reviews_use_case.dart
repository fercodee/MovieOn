import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/library/domain/repositories/library_repository.dart';

class GetReviewsUseCase {
  const GetReviewsUseCase(this._repository);

  final LibraryRepository _repository;

  Future<List<Review>> call() {
    return _repository.getReviews();
  }
}
