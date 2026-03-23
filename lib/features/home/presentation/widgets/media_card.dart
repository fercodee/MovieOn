import 'package:flutter/material.dart';

import 'package:move_on/core/config/api_config.dart';
import 'package:move_on/features/shared/domain/media_item.dart';

class MediaCard extends StatelessWidget {
  const MediaCard({super.key, required this.media, required this.onTap});

  final MediaItem media;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              height: 156,
              child: media.posterPath.isEmpty
                  ? Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.local_movies_outlined),
                    )
                  : Image.network(
                      '${ApiConfig.imageBaseUrl}${media.posterPath}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.broken_image_outlined),
                        );
                      },
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      media.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFB703),
                        ),
                        const SizedBox(width: 4),
                        Text(media.voteAverage.toStringAsFixed(1)),
                        const SizedBox(width: 12),
                        Text(media.year),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      media.overview.isEmpty
                          ? 'Sinopse indisponivel.'
                          : media.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
