import 'package:flutter_test/flutter_test.dart';

import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/catalog/domain/usecases/get_trending_media_use_case.dart';
import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

void main() {
  test('deve retornar a lista em destaque do repositorio', () async {
    const items = [
      MediaItem(
        id: 1,
        mediaType: MediaType.movie,
        title: 'Duna',
        overview: 'Teste',
        posterPath: '/duna.jpg',
        backdropPath: '/duna-bg.jpg',
        releaseDate: '2024-01-01',
        voteAverage: 8.7,
      ),
    ];

    final useCase = GetTrendingMediaUseCase(
      _FakeCatalogRepository(trendingItems: items),
    );

    final result = await useCase(MediaType.movie);

    expect(result, items);
  });
}

class _FakeCatalogRepository implements CatalogRepository {
  const _FakeCatalogRepository({this.trendingItems = const []});

  final List<MediaItem> trendingItems;

  @override
  Future<MediaDetails> getDetails({
    required int mediaId,
    required MediaType mediaType,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<MediaItem>> getTrending(MediaType mediaType) async =>
      trendingItems;

  @override
  Future<List<MediaItem>> search({
    required MediaType mediaType,
    required String query,
  }) async {
    return const [];
  }
}
