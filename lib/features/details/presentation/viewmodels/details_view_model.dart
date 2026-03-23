import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:move_on/core/di/app_providers.dart';
import 'package:move_on/features/details/presentation/state/details_state.dart';
import 'package:move_on/features/library/domain/entities/review.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

final detailsViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<DetailsViewModel, DetailsState, MediaArgs>(DetailsViewModel.new);

class MediaArgs extends Equatable {
  const MediaArgs({
    required this.mediaId,
    required this.mediaType,
    required this.mediaTitle,
  });

  factory MediaArgs.fromItem(MediaItem media) {
    return MediaArgs(
      mediaId: media.id,
      mediaType: media.mediaType,
      mediaTitle: media.title,
    );
  }

  final int mediaId;
  final MediaType mediaType;
  final String mediaTitle;

  @override
  List<Object?> get props => [mediaId, mediaType, mediaTitle];
}

class DetailsViewModel
    extends AutoDisposeFamilyAsyncNotifier<DetailsState, MediaArgs> {
  @override
  Future<DetailsState> build(MediaArgs arg) async {
    final details = await ref
        .read(getMediaDetailsUseCaseProvider)
        .call(mediaId: arg.mediaId, mediaType: arg.mediaType);
    final isFavorite = await ref
        .read(isFavoriteUseCaseProvider)
        .call(arg.mediaId);
    final review = await ref
        .read(getReviewForMediaUseCaseProvider)
        .call(arg.mediaId);

    return DetailsState(
      details: details,
      isFavorite: isFavorite,
      review: review,
    );
  }

  Future<void> toggleFavorite() async {
    final current = state.requireValue;
    final isFavorite = await ref
        .read(toggleFavoriteUseCaseProvider)
        .call(current.details.media);

    state = AsyncData(current.copyWith(isFavorite: isFavorite));
  }

  Future<void> saveReview({
    required String comment,
    required double rating,
  }) async {
    final current = state.requireValue;
    final review = Review(
      mediaId: current.details.media.id,
      mediaType: current.details.media.mediaType,
      mediaTitle: current.details.media.title,
      comment: comment.trim(),
      rating: rating,
      updatedAt: DateTime.now(),
    );

    await ref.read(saveReviewUseCaseProvider).call(review);
    state = AsyncData(current.copyWith(review: review));
  }

  Future<void> deleteReview() async {
    final current = state.requireValue;
    await ref.read(deleteReviewUseCaseProvider).call(current.details.media.id);
    state = AsyncData(current.copyWith(clearReview: true));
  }
}
