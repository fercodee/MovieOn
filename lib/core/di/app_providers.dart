import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:move_on/core/di/service_locator.dart';
import 'package:move_on/features/catalog/domain/usecases/get_trending_media_use_case.dart';
import 'package:move_on/features/catalog/domain/usecases/search_media_use_case.dart';
import 'package:move_on/features/details/domain/usecases/get_media_details_use_case.dart';
import 'package:move_on/features/library/domain/usecases/delete_review_use_case.dart';
import 'package:move_on/features/library/domain/usecases/get_favorites_use_case.dart';
import 'package:move_on/features/library/domain/usecases/get_review_for_media_use_case.dart';
import 'package:move_on/features/library/domain/usecases/get_reviews_use_case.dart';
import 'package:move_on/features/library/domain/usecases/is_favorite_use_case.dart';
import 'package:move_on/features/library/domain/usecases/save_review_use_case.dart';
import 'package:move_on/features/library/domain/usecases/toggle_favorite_use_case.dart';

final getTrendingMediaUseCaseProvider = Provider<GetTrendingMediaUseCase>(
  (ref) => getIt<GetTrendingMediaUseCase>(),
);

final searchMediaUseCaseProvider = Provider<SearchMediaUseCase>(
  (ref) => getIt<SearchMediaUseCase>(),
);

final getMediaDetailsUseCaseProvider = Provider<GetMediaDetailsUseCase>(
  (ref) => getIt<GetMediaDetailsUseCase>(),
);

final getFavoritesUseCaseProvider = Provider<GetFavoritesUseCase>(
  (ref) => getIt<GetFavoritesUseCase>(),
);

final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>(
  (ref) => getIt<ToggleFavoriteUseCase>(),
);

final isFavoriteUseCaseProvider = Provider<IsFavoriteUseCase>(
  (ref) => getIt<IsFavoriteUseCase>(),
);

final getReviewsUseCaseProvider = Provider<GetReviewsUseCase>(
  (ref) => getIt<GetReviewsUseCase>(),
);

final getReviewForMediaUseCaseProvider = Provider<GetReviewForMediaUseCase>(
  (ref) => getIt<GetReviewForMediaUseCase>(),
);

final saveReviewUseCaseProvider = Provider<SaveReviewUseCase>(
  (ref) => getIt<SaveReviewUseCase>(),
);

final deleteReviewUseCaseProvider = Provider<DeleteReviewUseCase>(
  (ref) => getIt<DeleteReviewUseCase>(),
);
