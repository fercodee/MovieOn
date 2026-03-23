import 'package:move_on/features/catalog/data/datasources/tmdb_remote_data_source.dart';
import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  const CatalogRepositoryImpl(this._remoteDataSource);

  final TmdbRemoteDataSource _remoteDataSource;

  @override
  Future<MediaDetails> getDetails({
    required int mediaId,
    required MediaType mediaType,
  }) {
    return _remoteDataSource.getDetails(mediaId: mediaId, mediaType: mediaType);
  }

  @override
  Future<List<MediaItem>> getTrending(MediaType mediaType) {
    return _remoteDataSource.getTrending(mediaType);
  }

  @override
  Future<List<MediaItem>> search({
    required MediaType mediaType,
    required String query,
  }) {
    return _remoteDataSource.search(mediaType: mediaType, query: query);
  }
}
