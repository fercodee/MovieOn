import 'package:move_on/features/library/domain/repositories/library_repository.dart';

class IsFavoriteUseCase {
  const IsFavoriteUseCase(this._repository);

  final LibraryRepository _repository;

  Future<bool> call(int mediaId) {
    return _repository.isFavorite(mediaId);
  }
}
