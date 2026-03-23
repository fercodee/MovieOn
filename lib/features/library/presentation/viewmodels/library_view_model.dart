import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:move_on/core/di/app_providers.dart';
import 'package:move_on/features/library/presentation/state/library_state.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

final libraryViewModelProvider =
    AsyncNotifierProvider<LibraryViewModel, LibraryState>(LibraryViewModel.new);

class LibraryViewModel extends AsyncNotifier<LibraryState> {
  @override
  Future<LibraryState> build() {
    return _load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> removeFavorite(MediaItem media) async {
    await ref.read(toggleFavoriteUseCaseProvider).call(media);
    await refresh();
  }

  Future<void> deleteReview(int mediaId) async {
    await ref.read(deleteReviewUseCaseProvider).call(mediaId);
    await refresh();
  }

  Future<LibraryState> _load() async {
    final favorites = await ref.read(getFavoritesUseCaseProvider).call();
    final reviews = await ref.read(getReviewsUseCaseProvider).call();

    return LibraryState(favorites: favorites, reviews: reviews);
  }
}
