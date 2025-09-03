import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;
  final String songId;

  SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
  });

    SongEntity copyWith({
    String? songId,
    String? title,
    String? artist,
    num? duration,
    bool? isFavorite,
    Timestamp? releaseDate,
  }) {
    return SongEntity(
      songId: songId ?? this.songId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }
}
