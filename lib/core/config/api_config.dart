class ApiConfig {
  const ApiConfig._();

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String apiKey = String.fromEnvironment('TMDB_API_KEY');

  static bool get hasApiKey => apiKey.trim().isNotEmpty;
}
