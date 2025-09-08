import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/configs/constants/repeat_mode.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/presentation/favorite/bloc/favorite_songs_cubit.dart';
import 'package:shopify/presentation/favorite/bloc/favorite_songs_state.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onPlayAllTap;

  const TopBar({
    super.key,
    required this.onPlayAllTap,
  });

  @override
  Widget build(BuildContext context) {
    // lấy repeatMode
    final repeatMode = context.select<PlayListCubit, RepeatMode>((cubit) {
      return cubit.state is PlayListLoaded
          ? (cubit.state as PlayListLoaded).repeatMode
          : RepeatMode.off;
    });

    // lấy danh sách favorites
    final favorites = context.select<FavoriteSongsCubit, List<String>>((cubit) {
      final state = cubit.state;
      return state is FavoriteSongsLoaded
          ? state.favoriteSongs.map((s) => s.songId).toList()
          : <String>[];
    });

    // check player state
    final isPlayingFavorite = context.select<SongPlayerCubit, bool>((player) {
      final state = player.state;
      if (state is! SongPlayerLoaded) return false;
      return favorites.contains(state.currentSong.songId) && state.isPlaying;
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              repeatMode == RepeatMode.one ? Icons.repeat_one : Icons.repeat,
              color:
                  repeatMode == RepeatMode.off ? Colors.grey : AppColors.primary,
            ),
            onPressed: () => context.read<PlayListCubit>().nextRepeatMode(),
          ),
          IconButton(
            onPressed: onPlayAllTap,
            icon: Icon(
              isPlayingFavorite ? Icons.pause_circle : Icons.play_circle,
              color: AppColors.primary,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
