import 'package:shopify/core/configs/constants/repeat_mode.dart';
import 'package:shopify/domain/entities/song/song.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;
  final int currentIndex;
  final RepeatMode repeatMode;

  PlayListLoaded({
    required this.songs,
    this.currentIndex = 0,
    this.repeatMode = RepeatMode.off,
  });

  SongEntity? get currentSong =>
      songs.isNotEmpty ? songs[currentIndex] : null;

  PlayListLoaded copyWith({
    List<SongEntity>? songs,
    int? currentIndex,
    RepeatMode? repeatMode,
  }) {
    return PlayListLoaded(
      songs: songs ?? this.songs,
      currentIndex: currentIndex ?? this.currentIndex,
      repeatMode: repeatMode ?? this.repeatMode,
    );
  }
}

class PlayListLoadFailure extends PlayListState {}
