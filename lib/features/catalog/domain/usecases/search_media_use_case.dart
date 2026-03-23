import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class SearchMediaUseCase {
  const SearchMediaUseCase(this._repository);

  final CatalogRepository _repository;

  Future<List<MediaItem>> call({
    required MediaType mediaType,
    required String query,
  }) {
    return _repository.search(mediaType: mediaType, query: query);
  }
}
