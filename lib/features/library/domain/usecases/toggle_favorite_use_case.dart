import 'package:move_on/features/library/domain/repositories/library_repository.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

class ToggleFavoriteUseCase {
  const ToggleFavoriteUseCase(this._repository);

  final LibraryRepository _repository;

  Future<bool> call(MediaItem media) async {
    final isFavorite = await _repository.isFavorite(media.id);

    if (isFavorite) {
      await _repository.removeFavorite(media.id);
      return false;
    }

    await _repository.saveFavorite(media);
    return true;
  }
}
