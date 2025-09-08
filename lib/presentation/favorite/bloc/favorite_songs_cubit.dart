import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/favorite/bloc/favorite_songs_state.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  final PlayListCubit playListCubit;
  final SongPlayerCubit songPlayerCubit;

  late final StreamSubscription _playlistSub;
  late final StreamSubscription _playerSub;

  FavoriteSongsCubit(this.playListCubit, this.songPlayerCubit)
      : super(FavoriteSongsLoading()) {
    // Lắng nghe thay đổi từ playlist
    _playlistSub = playListCubit.stream.listen((playlistState) {
      if (playlistState is PlayListLoaded) {
        final favorites =
            playlistState.songs.where((s) => s.isFavorite).toList();

        emit(FavoriteSongsLoaded(
          favoriteSongs: favorites,
          playingSongId: state is FavoriteSongsLoaded
              ? (state as FavoriteSongsLoaded).playingSongId
              : null,
        ));
      }
    });

    // Lắng nghe thay đổi từ player (để highlight bài đang phát)
    _playerSub = songPlayerCubit.stream.listen((playerState) {
      if (playerState is SongPlayerLoaded &&
          state is FavoriteSongsLoaded) {
        final current = state as FavoriteSongsLoaded;
        emit(current.copyWith(
          playingSongId: playerState.currentSong.songId,
        ));
      }
    });
  }

  void removeSong(String songId) {
    if (state is! FavoriteSongsLoaded) return;
    final current = state as FavoriteSongsLoaded;

    final updated =
        current.favoriteSongs.where((s) => s.songId != songId).toList();

    emit(current.copyWith(favoriteSongs: updated));

    // Sync ngược lại về playlist
    playListCubit.toggleFavorite(songId);
  }

  @override
  Future<void> close() {
    _playlistSub.cancel();
    _playerSub.cancel();
    return super.close();
  }
}
