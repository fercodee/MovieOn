import 'package:flutter_test/flutter_test.dart';

import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/library/domain/repositories/library_repository.dart';
import 'package:move_on/features/library/domain/usecases/toggle_favorite_use_case.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

void main() {
  test('deve salvar favorito quando item ainda nao existe', () async {
    final repository = _FakeLibraryRepository();
    const media = MediaItem(
      id: 9,
      mediaType: MediaType.movie,
      title: 'Batman',
      overview: 'Heroi',
      posterPath: '/batman.jpg',
      backdropPath: '/batman-bg.jpg',
      releaseDate: '2022-03-01',
      voteAverage: 7.8,
    );
    final useCase = ToggleFavoriteUseCase(repository);

    final result = await useCase(media);

    expect(result, isTrue);
    expect(repository.favorites, contains(media));
  });

  test('deve remover favorito quando item ja existe', () async {
    const media = MediaItem(
      id: 9,
      mediaType: MediaType.movie,
      title: 'Batman',
      overview: 'Heroi',
      posterPath: '/batman.jpg',
      backdropPath: '/batman-bg.jpg',
      releaseDate: '2022-03-01',
      voteAverage: 7.8,
    );
    final repository = _FakeLibraryRepository(initialFavorites: [media]);
    final useCase = ToggleFavoriteUseCase(repository);

    final result = await useCase(media);

    expect(result, isFalse);
    expect(repository.favorites, isEmpty);
  });
}

class _FakeLibraryRepository implements LibraryRepository {
  _FakeLibraryRepository({List<MediaItem>? initialFavorites})
    : favorites = [...?initialFavorites];

  final List<MediaItem> favorites;

  @override
  Future<void> deleteReview(int mediaId) async {}

  @override
  Future<List<MediaItem>> getFavorites() async => favorites;

  @override
  Future<Review?> getReviewForMedia(int mediaId) async => null;

  @override
  Future<List<Review>> getReviews() async => const [];

  @override
  Future<bool> isFavorite(int mediaId) async =>
      favorites.any((item) => item.id == mediaId);

  @override
  Future<void> removeFavorite(int mediaId) async {
    favorites.removeWhere((item) => item.id == mediaId);
  }

  @override
  Future<void> saveFavorite(MediaItem media) async {
    favorites.add(media);
  }

  @override
  Future<void> saveReview(Review review) async {}
}
