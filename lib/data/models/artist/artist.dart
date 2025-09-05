class Artist {
  final String id;
  final String name;
  final String imageUrl;
  final String bio;

  Artist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.bio,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      bio: json['bio'],
    );
  }
}
