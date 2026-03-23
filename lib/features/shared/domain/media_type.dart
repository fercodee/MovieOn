enum MediaType { movie, tv }

extension MediaTypeX on MediaType {
  String get tmdbPath => this == MediaType.movie ? 'movie' : 'tv';

  String get label => this == MediaType.movie ? 'Filmes' : 'Series';

  String get singularLabel => this == MediaType.movie ? 'filme' : 'serie';
}
