import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class GetTrendingMediaUseCase {
  const GetTrendingMediaUseCase(this._repository);

  final CatalogRepository _repository;

  Future<List<MediaItem>> call(MediaType mediaType) {
    return _repository.getTrending(mediaType);
  }
}
