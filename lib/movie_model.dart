class Movie {
  final String title;
  final String poster;
  final String genre;
  final double rating;

  Movie({
    required this.title,
    required this.poster,
    required this.genre,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      poster: json['Poster'],
      genre: json['Genre'] ?? 'N/A',
      rating: double.tryParse(json['imdbRating'] ?? '0') ?? 0.0,
    );
  }
}