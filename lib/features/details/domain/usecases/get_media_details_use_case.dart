import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class GetMediaDetailsUseCase {
  const GetMediaDetailsUseCase(this._repository);

  final CatalogRepository _repository;

  Future<MediaDetails> call({
    required int mediaId,
    required MediaType mediaType,
  }) {
    return _repository.getDetails(mediaId: mediaId, mediaType: mediaType);
  }
}
