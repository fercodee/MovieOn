import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/shared/data/models/media_item_model.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class MediaDetailsModel extends MediaDetails {
  const MediaDetailsModel({
    required super.media,
    required super.genres,
    required super.runtime,
    required super.numberOfSeasons,
    required super.homepage,
  });

  factory MediaDetailsModel.fromTmdbMap(
    Map<String, dynamic> map,
    MediaType type,
  ) {
    final media = MediaItemModel(
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

    final genres = (map['genres'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic genre) =>
              (genre as Map<String, dynamic>)['name'] as String? ?? '',
        )
        .where((genre) => genre.isNotEmpty)
        .toList();

    return MediaDetailsModel(
      media: media,
      genres: genres,
      runtime: ((map['runtime'] ?? 0) as num).toInt(),
      numberOfSeasons: ((map['number_of_seasons'] ?? 0) as num).toInt(),
      homepage: (map['homepage'] ?? '') as String,
    );
  }

  factory MediaDetailsModel.fromEntity(MediaDetails details) {
    return MediaDetailsModel(
      media: details.media,
      genres: details.genres,
      runtime: details.runtime,
      numberOfSeasons: details.numberOfSeasons,
      homepage: details.homepage,
    );
  }

  MediaItem get item => media;
}
