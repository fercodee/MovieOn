import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/library/domain/repositories/library_repository.dart';

class GetReviewForMediaUseCase {
  const GetReviewForMediaUseCase(this._repository);

  final LibraryRepository _repository;

  Future<Review?> call(int mediaId) {
    return _repository.getReviewForMedia(mediaId);
  }
}
