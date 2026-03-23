import 'package:equatable/equatable.dart';

import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

class LibraryState extends Equatable {
  const LibraryState({required this.favorites, required this.reviews});

  final List<MediaItem> favorites;
  final List<Review> reviews;

  @override
  List<Object?> get props => [favorites, reviews];
}
