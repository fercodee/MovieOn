import 'package:equatable/equatable.dart';

import 'package:move_on/features/shared/domain/media_type.dart';

class MediaItem extends Equatable {
  const MediaItem({
    required this.id,
    required this.mediaType,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  final int id;
  final MediaType mediaType;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;

  String get year {
    if (releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }

    return 'N/D';
  }

  MediaItem copyWith({
    int? id,
    MediaType? mediaType,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    double? voteAverage,
  }) {
    return MediaItem(
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    mediaType,
    title,
    overview,
    posterPath,
    backdropPath,
    releaseDate,
    voteAverage,
  ];
}
