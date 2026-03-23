import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:move_on/features/details/presentation/screens/details_screen.dart';
import 'package:move_on/features/home/presentation/widgets/media_card.dart';
import 'package:move_on/features/library/presentation/viewmodels/library_view_model.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryAsync = ref.watch(libraryViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(libraryViewModelProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: libraryAsync.when(
        data: (state) {
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(libraryViewModelProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Favoritos',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                if (state.favorites.isEmpty)
                  const _SectionMessage(
                    message:
                        'Nenhum titulo foi adicionado aos favoritos ainda.',
                  )
                else
                  ...state.favorites.map(
                    (media) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Stack(
                        children: [
                          MediaCard(
                            media: media,
                            onTap: () => _openDetails(context, media),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: IconButton.filledTonal(
                              onPressed: () {
                                ref
                                    .read(libraryViewModelProvider.notifier)
                                    .removeFavorite(media);
                              },
                              icon: const Icon(Icons.favorite_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 28),
                Text(
                  'Resenhas salvas',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                if (state.reviews.isEmpty)
                  const _SectionMessage(
                    message: 'Nenhuma resenha foi salva ainda.',
                  )
                else
                  ...state.reviews.map(
                    (review) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      review.mediaTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                            libraryViewModelProvider.notifier,
                                          )
                                          .deleteReview(review.mediaId);
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Avaliacao pessoal: ${review.rating.toStringAsFixed(1)} / 5',
                              ),
                              const SizedBox(height: 8),
                              Text(review.comment),
                              const SizedBox(height: 12),
                              Text(
                                'Ultima atualizacao: ${DateFormat('dd/MM/yyyy HH:mm').format(review.updatedAt)}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => _LibraryErrorMessage(
          message: error.toString(),
          onRetry: () => ref.read(libraryViewModelProvider.notifier).refresh(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> _openDetails(BuildContext context, MediaItem media) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => DetailsScreen(media: media)),
    );
  }
}

class _SectionMessage extends StatelessWidget {
  const _SectionMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: const EdgeInsets.all(20), child: Text(message)),
    );
  }
}

class _LibraryErrorMessage extends StatelessWidget {
  const _LibraryErrorMessage({required this.message, required this.onRetry});

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
