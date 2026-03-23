import 'package:dio/dio.dart';

import 'package:move_on/core/config/api_config.dart';
import 'package:move_on/core/errors/app_exception.dart';
import 'package:move_on/features/details/data/models/media_details_model.dart';
import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/shared/data/models/media_item_model.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

abstract class TmdbRemoteDataSource {
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

class TmdbRemoteDataSourceImpl implements TmdbRemoteDataSource {
  const TmdbRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<MediaItem>> getTrending(MediaType mediaType) async {
    final data = await _get(path: '/trending/${mediaType.tmdbPath}/week');

    return _extractResults(data, mediaType);
  }

  @override
  Future<List<MediaItem>> search({
    required MediaType mediaType,
    required String query,
  }) async {
    final sanitizedQuery = query.trim();
    if (sanitizedQuery.isEmpty) {
      return getTrending(mediaType);
    }

    final data = await _get(
      path: '/search/${mediaType.tmdbPath}',
      queryParameters: {'query': sanitizedQuery, 'include_adult': false},
    );

    return _extractResults(data, mediaType);
  }

  @override
  Future<MediaDetails> getDetails({
    required int mediaId,
    required MediaType mediaType,
  }) async {
    final data = await _get(path: '/${mediaType.tmdbPath}/$mediaId');
    return MediaDetailsModel.fromTmdbMap(data, mediaType);
  }

  Future<Map<String, dynamic>> _get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!ApiConfig.hasApiKey) {
      throw const AppException(
        'Configure a chave da TMDB com --dart-define=TMDB_API_KEY=... para carregar o catalogo.',
      );
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {
          'api_key': ApiConfig.apiKey,
          'language': 'pt-BR',
          ...?queryParameters,
        },
      );

      return response.data ?? <String, dynamic>{};
    } on DioException catch (error) {
      final message = error.response?.data is Map<String, dynamic>
          ? (error.response?.data['status_message'] as String? ??
                'Erro ao acessar a TMDB.')
          : 'Erro ao acessar a TMDB.';

      throw AppException(message);
    }
  }

  List<MediaItem> _extractResults(Map<String, dynamic> data, MediaType type) {
    final results = data['results'] as List<dynamic>? ?? <dynamic>[];

    return results
        .whereType<Map<String, dynamic>>()
        .map((item) => MediaItemModel.fromTmdbMap(item, type))
        .where((item) => item.title.trim().isNotEmpty)
        .toList();
  }
}
