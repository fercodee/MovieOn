import 'package:equatable/equatable.dart';

import 'package:move_on/features/details/domain/entities/media_details.dart';
import 'package:move_on/features/library/domain/entities/review.dart';

class DetailsState extends Equatable {
  const DetailsState({
    required this.details,
    required this.isFavorite,
    required this.review,
  });

  final MediaDetails details;
  final bool isFavorite;
  final Review? review;

  DetailsState copyWith({
    MediaDetails? details,
    bool? isFavorite,
    Review? review,
    bool clearReview = false,
  }) {
    return DetailsState(
      details: details ?? this.details,
      isFavorite: isFavorite ?? this.isFavorite,
      review: clearReview ? null : review ?? this.review,
    );
  }

  @override
  List<Object?> get props => [details, isFavorite, review];
}
