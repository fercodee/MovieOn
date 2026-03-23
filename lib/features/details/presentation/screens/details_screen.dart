import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:move_on/core/config/api_config.dart';
import 'package:move_on/features/details/presentation/viewmodels/details_view_model.dart';
import 'package:move_on/features/library/presentation/viewmodels/library_view_model.dart';
import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key, required this.media});

  final MediaItem media;

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  late final TextEditingController _reviewController;
  double _rating = 4;

  @override
  void initState() {
    super.initState();
    _reviewController = TextEditingController();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = MediaArgs.fromItem(widget.media);
    final detailsAsync = ref.watch(detailsViewModelProvider(args));

    return Scaffold(
      body: detailsAsync.when(
        data: (state) {
          final review = state.review;

          if (_reviewController.text.isEmpty && review != null) {
            _reviewController.text = review.comment;
            _rating = review.rating;
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: true,
                title: Text(state.details.media.title),
                actions: [
                  IconButton(
                    onPressed: () async {
                      await ref
                          .read(detailsViewModelProvider(args).notifier)
                          .toggleFavorite();
                      ref.invalidate(libraryViewModelProvider);
                    },
                    icon: Icon(
                      state.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: state.details.media.backdropPath.isEmpty
                      ? Container(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                        )
                      : Image.network(
                          '${ApiConfig.imageBaseUrl}${state.details.media.backdropPath}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                            );
                          },
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _InfoChip(label: state.details.media.mediaType.label),
                          _InfoChip(label: state.details.media.year),
                          _InfoChip(label: state.details.durationLabel),
                          _InfoChip(
                            label:
                                'TMDB ${state.details.media.voteAverage.toStringAsFixed(1)}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Sinopse',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.details.media.overview.isEmpty
                            ? 'Sinopse indisponivel no momento.'
                            : state.details.media.overview,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Generos',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.details.genres
                            .map((genre) => _InfoChip(label: genre))
                            .toList(),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Resenha pessoal',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _reviewController,
                        minLines: 4,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: 'Escreva sua resenha sobre este titulo',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Avaliacao pessoal: ${_rating.toStringAsFixed(1)} / 5',
                      ),
                      Slider(
                        min: 0,
                        max: 5,
                        divisions: 10,
                        value: _rating,
                        label: _rating.toStringAsFixed(1),
                        onChanged: (value) => setState(() => _rating = value),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () async {
                                if (_reviewController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Digite um comentario antes de salvar a resenha.',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                await ref
                                    .read(
                                      detailsViewModelProvider(args).notifier,
                                    )
                                    .saveReview(
                                      comment: _reviewController.text,
                                      rating: _rating,
                                    );
                                ref.invalidate(libraryViewModelProvider);

                                if (!context.mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      review == null
                                          ? 'Resenha salva.'
                                          : 'Resenha atualizada.',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.rate_review_rounded),
                              label: Text(
                                review == null
                                    ? 'Salvar resenha'
                                    : 'Atualizar resenha',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton.filledTonal(
                            onPressed: review == null
                                ? null
                                : () async {
                                    await ref
                                        .read(
                                          detailsViewModelProvider(
                                            args,
                                          ).notifier,
                                        )
                                        .deleteReview();
                                    ref.invalidate(libraryViewModelProvider);
                                    _reviewController.clear();
                                    setState(() => _rating = 4);

                                    if (!context.mounted) {
                                      return;
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Resenha excluida.'),
                                      ),
                                    );
                                  },
                            icon: const Icon(Icons.delete_outline_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded, size: 40),
                const SizedBox(height: 12),
                Text(error.toString(), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
