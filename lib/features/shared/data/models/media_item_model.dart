import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class MediaItemModel extends MediaItem {
  const MediaItemModel({
    required super.id,
    required super.mediaType,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.releaseDate,
    required super.voteAverage,
  });

  factory MediaItemModel.fromTmdbMap(Map<String, dynamic> map, MediaType type) {
    return MediaItemModel(
      id: map['id'] as int? ?? 0,
      mediaType: type,
      title: (map['title'] ?? map['name'] ?? 'Sem titulo') as String,
      overview: (map['overview'] ?? '') as String,
      posterPath: (map['poster_path'] ?? '') as String,
      backdropPath: (map['backdrop_path'] ?? '') as String,
      releaseDate:
          (map['release_date'] ?? map['first_air_date'] ?? '') as String,
      voteAverage: ((map['vote_average'] ?? 0) as num).toDouble(),
    );
  }

  factory MediaItemModel.fromLocalMap(Map<String, dynamic> map) {
    return MediaItemModel(
      id: map['id'] as int,
      mediaType: (map['mediaType'] as String) == 'movie'
          ? MediaType.movie
          : MediaType.tv,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath: map['posterPath'] as String,
      backdropPath: map['backdropPath'] as String,
      releaseDate: map['releaseDate'] as String,
      voteAverage: (map['voteAverage'] as num).toDouble(),
    );
  }

  factory MediaItemModel.fromEntity(MediaItem media) {
    return MediaItemModel(
      id: media.id,
      mediaType: media.mediaType,
      title: media.title,
      overview: media.overview,
      posterPath: media.posterPath,
      backdropPath: media.backdropPath,
      releaseDate: media.releaseDate,
      voteAverage: media.voteAverage,
    );
  }

  Map<String, dynamic> toLocalMap() {
    return {
      'id': id,
      'mediaType': mediaType.name,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
    };
  }
}
