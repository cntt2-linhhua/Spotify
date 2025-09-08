import 'package:shopify/domain/entities/song/song.dart';

abstract class FavoriteSongsState {
  const FavoriteSongsState();

  List<Object?> get props => [];
}

class FavoriteSongsLoading extends FavoriteSongsState {}

class FavoriteSongsLoaded extends FavoriteSongsState {
  final List<SongEntity> favoriteSongs;
  final String? playingSongId;

  const FavoriteSongsLoaded({
    required this.favoriteSongs,
    this.playingSongId,
  });

  FavoriteSongsLoaded copyWith({
    List<SongEntity>? favoriteSongs,
    String? playingSongId,
  }) {
    return FavoriteSongsLoaded(
      favoriteSongs: favoriteSongs ?? this.favoriteSongs,
      playingSongId: playingSongId ?? this.playingSongId,
    );
  }

  @override
  List<Object?> get props => [favoriteSongs, playingSongId];
}

class FavoriteSongsFailure extends FavoriteSongsState {}
