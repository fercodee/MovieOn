import 'package:move_on/features/library/domain/repositories/library_repository.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

class GetFavoritesUseCase {
  const GetFavoritesUseCase(this._repository);

  final LibraryRepository _repository;

  Future<List<MediaItem>> call() {
    return _repository.getFavorites();
  }
}
