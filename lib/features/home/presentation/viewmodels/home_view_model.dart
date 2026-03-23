import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:move_on/core/di/app_providers.dart';
import 'package:move_on/features/home/presentation/state/home_state.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeState>(
  HomeViewModel.new,
);

class HomeViewModel extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() {
    return _load(mediaType: MediaType.movie, query: '');
  }

  Future<void> refresh() async {
    final current = state.valueOrNull;
    if (current == null) {
      state = await AsyncValue.guard(build);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _load(mediaType: current.selectedType, query: current.query),
    );
  }

  Future<void> search(String query) async {
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _load(mediaType: current.selectedType, query: query),
    );
  }

  Future<void> setMediaType(MediaType mediaType) async {
    final current = state.valueOrNull;
    final query = current?.query ?? '';

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _load(mediaType: mediaType, query: query),
    );
  }

  Future<HomeState> _load({
    required MediaType mediaType,
    required String query,
  }) async {
    final trimmedQuery = query.trim();

    final items = trimmedQuery.isEmpty
        ? await ref.read(getTrendingMediaUseCaseProvider).call(mediaType)
        : await ref
              .read(searchMediaUseCaseProvider)
              .call(mediaType: mediaType, query: trimmedQuery);

    return HomeState(
      selectedType: mediaType,
      query: trimmedQuery,
      items: items,
    );
  }
}
