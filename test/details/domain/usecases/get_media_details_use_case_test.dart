import 'package:flutter_test/flutter_test.dart';

import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/details/domain/usecases/get_media_details_use_case.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

void main() {
  test('deve retornar os detalhes do titulo solicitado', () async {
    const expected = MediaDetails(
      media: MediaItem(
        id: 15,
        mediaType: MediaType.movie,
        title: 'Oppenheimer',
        overview: 'Detalhes',
        posterPath: '/opp.jpg',
        backdropPath: '/opp-bg.jpg',
        releaseDate: '2023-07-20',
        voteAverage: 8.4,
      ),
      genres: ['Drama'],
      runtime: 180,
      numberOfSeasons: 0,
      homepage: 'https://example.com',
    );

    final useCase = GetMediaDetailsUseCase(_FakeCatalogRepository(expected));

    final result = await useCase(mediaId: 15, mediaType: MediaType.movie);

    expect(result, expected);
  });
}

class _FakeCatalogRepository implements CatalogRepository {
  const _FakeCatalogRepository(this.details);

  final MediaDetails details;

  @override
  Future<MediaDetails> getDetails({required int mediaId, required MediaType mediaType}) async {
    return details;
  }

  @override
  Future<List<MediaItem>> getTrending(MediaType mediaType) {
    throw UnimplementedError();
  }

  @override
  Future<List<MediaItem>> search({required MediaType mediaType, required String query}) {
    throw UnimplementedError();
  }
}