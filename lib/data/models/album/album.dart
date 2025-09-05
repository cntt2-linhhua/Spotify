class Album {
  final String id;
  final String title;
  final String artistId;
  final String coverUrl;
  final String releaseDate;

  Album({
    required this.id,
    required this.title,
    required this.artistId,
    required this.coverUrl,
    required this.releaseDate,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      artistId: json['artistId'],
      coverUrl: json['coverUrl'],
      releaseDate: json['releaseDate'],
    );
  }
}
