import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:move_on/features/details/presentation/screens/details_screen.dart';
import 'package:move_on/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:move_on/features/home/presentation/widgets/media_card.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeAsync = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieOn'),
        actions: [
          IconButton(
            onPressed: () => ref.read(homeViewModelProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: homeAsync.when(
        data: (state) {
          _searchController.value = _searchController.value.copyWith(
            text: state.query,
            selection: TextSelection.collapsed(offset: state.query.length),
          );

          return RefreshIndicator(
            onRefresh: () => ref.read(homeViewModelProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Explore filmes e series, acompanhe detalhes e organize sua biblioteca pessoal.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Buscar titulos',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: state.query.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(homeViewModelProvider.notifier)
                                  .search('');
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                  ),
                  onSubmitted: (value) {
                    ref.read(homeViewModelProvider.notifier).search(value);
                  },
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  children: MediaType.values
                      .map(
                        (type) => ChoiceChip(
                          label: Text(type.label),
                          selected: state.selectedType == type,
                          onSelected: (_) {
                            ref
                                .read(homeViewModelProvider.notifier)
                                .setMediaType(type);
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                Text(
                  state.isSearching
                      ? 'Resultados da busca por "${state.query}"'
                      : '${state.selectedType.label} em destaque',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                if (state.items.isEmpty)
                  const _EmptyMessage(
                    message: 'Nenhum titulo encontrado. Tente outro termo.',
                  )
                else
                  ...state.items.map(
                    (media) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: MediaCard(
                        media: media,
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => DetailsScreen(media: media),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => _ErrorMessage(
          message: error.toString(),
          onRetry: () => ref.read(homeViewModelProvider.notifier).refresh(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  const _EmptyMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.movie_filter_outlined, size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 40),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
