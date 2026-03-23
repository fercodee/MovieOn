import 'package:flutter_test/flutter_test.dart';

import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/catalog/domain/usecases/search_media_use_case.dart';
import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

void main() {
  test('deve delegar a busca para o repositorio com o termo informado', () async {
    const expected = [
      MediaItem(
        id: 7,
        mediaType: MediaType.tv,
        title: 'The Last of Us',
        overview: 'Busca',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        releaseDate: '2023-01-15',
        voteAverage: 8.9,
      ),
    ];

    final repository = _FakeCatalogRepository(searchItems: expected);
    final useCase = SearchMediaUseCase(repository);

    final result = await useCase(mediaType: MediaType.tv, query: 'last');

    expect(result, expected);
  });
}

class _FakeCatalogRepository implements CatalogRepository {
  const _FakeCatalogRepository({this.searchItems = const []});

  final List<MediaItem> searchItems;

  @override
  Future<MediaDetails> getDetails({required int mediaId, required MediaType mediaType}) {
    throw UnimplementedError();
  }

  @override
  Future<List<MediaItem>> getTrending(MediaType mediaType) {
    throw UnimplementedError();
  }

  @override
  Future<List<MediaItem>> search({required MediaType mediaType, required String query}) async {
    return searchItems;
  }
}