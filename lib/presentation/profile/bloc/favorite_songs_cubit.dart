import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/profile/bloc/favorite_songs_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  final PlayListCubit playListCubit;
  late final StreamSubscription subscription;

  FavoriteSongsCubit(this.playListCubit) : super(FavoriteSongsLoading()) {
    // Lắng nghe thay đổi từ PlayListCubit
    subscription = playListCubit.stream.listen((playlistState) {
      if (playlistState is PlayListLoaded) {
        final favorites = playlistState.songs.where((s) => s.isFavorite).toList();

        emit(FavoriteSongsLoaded(favoriteSongs: favorites.isEmpty ? [] : favorites));
      }
    });
  }

  void removeSong(String songId) {
    if (state is FavoriteSongsLoaded) {
      final current = (state as FavoriteSongsLoaded).favoriteSongs;
      final updated = current.where((s) => s.songId != songId).toList();
      emit(FavoriteSongsLoaded(favoriteSongs: updated));
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
