import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:move_on/core/config/api_config.dart';
import 'package:move_on/features/catalog/data/datasources/tmdb_remote_data_source.dart';
import 'package:move_on/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:move_on/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:move_on/features/catalog/domain/usecases/get_trending_media_use_case.dart';
import 'package:move_on/features/catalog/domain/usecases/search_media_use_case.dart';
import 'package:move_on/features/details/domain/usecases/get_media_details_use_case.dart';
import 'package:move_on/features/library/data/datasources/library_local_data_source.dart';
import 'package:move_on/features/library/data/repositories/library_repository_impl.dart';
import 'package:move_on/features/library/domain/repositories/library_repository.dart';
import 'package:move_on/features/library/domain/usecases/delete_review_use_case.dart';
import 'package:move_on/features/library/domain/usecases/get_favorites_use_case.dart';
import 'package:move_on/features/library/domain/usecases/get_review_for_media_use_case.dart';
import 'package:move_on/features/library/domain/usecases/get_reviews_use_case.dart';
import 'package:move_on/features/library/domain/usecases/is_favorite_use_case.dart';
import 'package:move_on/features/library/domain/usecases/save_review_use_case.dart';
import 'package:move_on/features/library/domain/usecases/toggle_favorite_use_case.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  if (getIt.isRegistered<Dio>()) {
    return;
  }

  final preferences = await SharedPreferences.getInstance();

  getIt
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      ),
    )
    ..registerLazySingleton<SharedPreferences>(() => preferences)
    ..registerLazySingleton<TmdbRemoteDataSource>(
      () => TmdbRemoteDataSourceImpl(getIt<Dio>()),
    )
    ..registerLazySingleton<LibraryLocalDataSource>(
      () => LibraryLocalDataSourceImpl(getIt<SharedPreferences>()),
    )
    ..registerLazySingleton<CatalogRepository>(
      () => CatalogRepositoryImpl(getIt<TmdbRemoteDataSource>()),
    )
    ..registerLazySingleton<LibraryRepository>(
      () => LibraryRepositoryImpl(getIt<LibraryLocalDataSource>()),
    )
    ..registerLazySingleton(
      () => GetTrendingMediaUseCase(getIt<CatalogRepository>()),
    )
    ..registerLazySingleton(
      () => SearchMediaUseCase(getIt<CatalogRepository>()),
    )
    ..registerLazySingleton(
      () => GetMediaDetailsUseCase(getIt<CatalogRepository>()),
    )
    ..registerLazySingleton(
      () => GetFavoritesUseCase(getIt<LibraryRepository>()),
    )
    ..registerLazySingleton(
      () => ToggleFavoriteUseCase(getIt<LibraryRepository>()),
    )
    ..registerLazySingleton(() => IsFavoriteUseCase(getIt<LibraryRepository>()))
    ..registerLazySingleton(() => GetReviewsUseCase(getIt<LibraryRepository>()))
    ..registerLazySingleton(
      () => GetReviewForMediaUseCase(getIt<LibraryRepository>()),
    )
    ..registerLazySingleton(() => SaveReviewUseCase(getIt<LibraryRepository>()))
    ..registerLazySingleton(
      () => DeleteReviewUseCase(getIt<LibraryRepository>()),
    );
}
