import 'package:move_on/features/library/domain/repositories/library_repository.dart';

class DeleteReviewUseCase {
  const DeleteReviewUseCase(this._repository);

  final LibraryRepository _repository;

  Future<void> call(int mediaId) {
    return _repository.deleteReview(mediaId);
  }
}
