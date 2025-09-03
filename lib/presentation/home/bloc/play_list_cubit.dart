import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/configs/constants/repeat_mode.dart';
import 'package:shopify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:shopify/domain/usecases/song/get_play_list.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold(
      (l) => emit(PlayListLoadFailure()),
      (data) => emit(
        PlayListLoaded(songs: data, currentIndex: 0),
      ),
    );
  }

  void nextRepeatMode() {
    if (state is PlayListLoaded) {
      final current = state as PlayListLoaded;
      RepeatMode nextMode;
      switch (current.repeatMode) {
        case RepeatMode.off:
          nextMode = RepeatMode.all;
          break;
        case RepeatMode.all:
          nextMode = RepeatMode.one;
          break;
        case RepeatMode.one:
          nextMode = RepeatMode.off;
          break;
      }
      emit(current.copyWith(repeatMode: nextMode));
    }
  }

  void setCurrentIndex(int index) {
    if (state is PlayListLoaded) {
      final current = state as PlayListLoaded;
      emit(current.copyWith(currentIndex: index));
    }
  }

  Future<void> toggleFavorite(String songId) async {
  if (state is! PlayListLoaded) return;

  final current = state as PlayListLoaded;

  final result = await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songId);

  result.fold(
    (error) {
      // TODO: handle error (SnackBar, log, v.v.)
    },
    (isFavorite) {
      // update list
      final updatedSongs = current.songs.map((s) {
        return s.songId == songId ? s.copyWith(isFavorite: isFavorite) : s;
      }).toList();

      final newState = current.copyWith(songs: updatedSongs);
      emit(newState);

      // 🔑 sync sang SongPlayerCubit
      final updatedSong = updatedSongs.firstWhere((s) => s.songId == songId);
      sl<SongPlayerCubit>().updateFavoriteFromPlaylist(updatedSong);
    },
  );
}


}
