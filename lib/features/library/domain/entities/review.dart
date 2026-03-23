import 'package:equatable/equatable.dart';

import 'package:move_on/features/shared/domain/media_type.dart';

class Review extends Equatable {
  const Review({
    required this.mediaId,
    required this.mediaType,
    required this.mediaTitle,
    required this.comment,
    required this.rating,
    required this.updatedAt,
  });

  final int mediaId;
  final MediaType mediaType;
  final String mediaTitle;
  final String comment;
  final double rating;
  final DateTime updatedAt;

  Review copyWith({
    int? mediaId,
    MediaType? mediaType,
    String? mediaTitle,
    String? comment,
    double? rating,
    DateTime? updatedAt,
  }) {
    return Review(
      mediaId: mediaId ?? this.mediaId,
      mediaType: mediaType ?? this.mediaType,
      mediaTitle: mediaTitle ?? this.mediaTitle,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    mediaId,
    mediaType,
    mediaTitle,
    comment,
    rating,
    updatedAt,
  ];
}
