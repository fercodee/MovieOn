import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:move_on/features/library/data/datasources/library_local_data_source.dart';
import 'package:move_on/features/library/data/repositories/library_repository_impl.dart';
import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

void main() {
  test(
    'saveReview atualiza a lista sem erro de tipo ao misturar entidade e model',
    () async {
      SharedPreferences.setMockInitialValues({
        'movie_on_reviews': jsonEncode([
          {
            'mediaId': 1,
            'mediaType': 'movie',
            'mediaTitle': 'Interestelar',
            'comment': 'Excelente.',
            'rating': 4.5,
            'updatedAt': '2026-03-29T10:00:00.000',
          },
        ]),
      });

      final preferences = await SharedPreferences.getInstance();
      final dataSource = LibraryLocalDataSourceImpl(preferences);
      final repository = LibraryRepositoryImpl(dataSource);

      final review = Review(
        mediaId: 2,
        mediaType: MediaType.tv,
        mediaTitle: 'Ruptura',
        comment: 'Muito boa.',
        rating: 5,
        updatedAt: DateTime(2026, 3, 29, 12),
      );

      await repository.saveReview(review);

      final reviews = await repository.getReviews();

      expect(reviews, hasLength(2));
      expect(reviews.any((item) => item.mediaId == review.mediaId), isTrue);
    },
  );
}
