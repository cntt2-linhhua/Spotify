class SongV2 {
  final String id;
  final String title;
  final String artistId;
  final String albumId;
  final int duration;
  final String audioUrl;
  final int playCount;
  final bool isFavorite;

  SongV2({
    required this.id,
    required this.title,
    required this.artistId,
    required this.albumId,
    required this.duration,
    required this.audioUrl,
    required this.playCount,
    required this.isFavorite,
  });

  factory SongV2.fromJson(Map<String, dynamic> json) {
    return SongV2(
      id: json['id'],
      title: json['title'],
      artistId: json['artistId'],
      albumId: json['albumId'],
      duration: json['duration'],
      audioUrl: json['audioUrl'],
      playCount: json['playCount'],
      isFavorite: json['isFavorite'],
    );
  }
}
