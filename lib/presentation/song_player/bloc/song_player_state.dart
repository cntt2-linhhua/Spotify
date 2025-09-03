import 'package:shopify/domain/entities/song/song.dart';

abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final Duration songDuration;
  final Duration songPosition;
  final bool isPlaying;
  final SongEntity currentSong;

  SongPlayerLoaded({
    required this.songDuration,
    required this.songPosition,
    required this.isPlaying,
    required this.currentSong,
  });

  SongPlayerLoaded copyWith({
    Duration? songDuration,
    Duration? songPosition,
    bool? isPlaying,
    SongEntity? currentSong,
  }) {
    return SongPlayerLoaded(
      songDuration: songDuration ?? this.songDuration,
      songPosition: songPosition ?? this.songPosition,
      isPlaying: isPlaying ?? this.isPlaying,
      currentSong: currentSong ?? this.currentSong,
    );
  }
}

class SongPlayerFailure extends SongPlayerState {}
