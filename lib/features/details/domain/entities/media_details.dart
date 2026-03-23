import 'package:equatable/equatable.dart';

import 'package:move_on/features/shared/domain/media_item.dart';

class MediaDetails extends Equatable {
  const MediaDetails({
    required this.media,
    required this.genres,
    required this.runtime,
    required this.numberOfSeasons,
    required this.homepage,
  });

  final MediaItem media;
  final List<String> genres;
  final int runtime;
  final int numberOfSeasons;
  final String homepage;

  String get durationLabel {
    if (runtime > 0) {
      return '$runtime min';
    }

    if (numberOfSeasons > 0) {
      return '$numberOfSeasons temporada(s)';
    }

    return 'Sem duracao informada';
  }

  @override
  List<Object?> get props => [
    media,
    genres,
    runtime,
    numberOfSeasons,
    homepage,
  ];
}
