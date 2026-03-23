import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

abstract class CatalogRepository {
  Future<List<MediaItem>> getTrending(MediaType mediaType);

  Future<List<MediaItem>> search({
    required MediaType mediaType,
    required String query,
  });

  Future<MediaDetails> getDetails({
    required int mediaId,
    required MediaType mediaType,
  });
}
