import 'package:flutter_test/flutter_test.dart';

import 'package:move_on/features/shared/data/models/media_item_model.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

void main() {
  test('deve mapear o payload da TMDB para MediaItemModel', () {
    final model = MediaItemModel.fromTmdbMap({
      'id': 44,
      'title': 'Interestelar',
      'overview': 'Espaco e tempo.',
      'poster_path': '/interestelar.jpg',
      'backdrop_path': '/interestelar-bg.jpg',
      'release_date': '2014-11-06',
      'vote_average': 8.6,
    }, MediaType.movie);

    expect(model.id, 44);
    expect(model.title, 'Interestelar');
    expect(model.mediaType, MediaType.movie);
    expect(model.posterPath, '/interestelar.jpg');
  });
}
