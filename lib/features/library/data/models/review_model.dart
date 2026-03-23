import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.mediaId,
    required super.mediaType,
    required super.mediaTitle,
    required super.comment,
    required super.rating,
    required super.updatedAt,
  });

  factory ReviewModel.fromEntity(Review review) {
    return ReviewModel(
      mediaId: review.mediaId,
      mediaType: review.mediaType,
      mediaTitle: review.mediaTitle,
      comment: review.comment,
      rating: review.rating,
      updatedAt: review.updatedAt,
    );
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      mediaId: map['mediaId'] as int,
      mediaType: (map['mediaType'] as String) == 'movie'
          ? MediaType.movie
          : MediaType.tv,
      mediaTitle: map['mediaTitle'] as String,
      comment: map['comment'] as String,
      rating: (map['rating'] as num).toDouble(),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mediaId': mediaId,
      'mediaType': mediaType.name,
      'mediaTitle': mediaTitle,
      'comment': comment,
      'rating': rating,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
