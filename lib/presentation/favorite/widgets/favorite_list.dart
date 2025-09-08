import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/presentation/favorite/bloc/favorite_songs_cubit.dart';
import 'package:shopify/presentation/favorite/bloc/favorite_songs_state.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  void _showMoreMenu(BuildContext context, String songId) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: ListTile(
          leading: const Icon(Icons.delete_outline),
          title: const Text("Remove from favorites"),
          onTap: () {
            Navigator.pop(context);
            context.read<PlayListCubit>().toggleFavorite(songId);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
      builder: (context, favState) {
        if (favState is FavoriteSongsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (favState is FavoriteSongsLoaded) {
          if (favState.favoriteSongs.isEmpty) {
            return const Center(child: Text("No favorite songs"));
          }

          // lấy state hiện tại từ SongPlayerCubit
          final currentSongId = context.select<SongPlayerCubit, String?>((player) {
            final state = player.state;
            return state is SongPlayerLoaded ? state.currentSong.songId : null;
          });

          final isPlaying = context.select<SongPlayerCubit, bool>((player) {
            final state = player.state;
            return state is SongPlayerLoaded && state.isPlaying;
          });

          return ListView.builder(
            itemCount: favState.favoriteSongs.length,
            itemBuilder: (context, index) {
              final song = favState.favoriteSongs[index];
              final isCurrent = song.songId == currentSongId;

              return ListTile(
                contentPadding: EdgeInsetsDirectional.only(
                  start: 16.0,
                  end: 8.0,
                ),
                leading: Icon(
                  isCurrent && isPlaying ? Icons.play_circle : Icons.music_note,
                  color: isCurrent ? AppColors.primary : Colors.grey,
                ),
                title: Text(
                  song.title,
                  style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCurrent ? AppColors.primary : null,
                  ),
                ),
                subtitle: Text(song.artist),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showMoreMenu(context, song.songId),
                ),
                onTap: () {
                  final player = context.read<SongPlayerCubit>();
                  final state = player.state;
                  final isThisCurrent =
                      state is SongPlayerLoaded && state.currentSong.songId == song.songId;

                  if (isThisCurrent) {
                    player.playOrPauseSong();
                  } else {
                    player.loadSong(song).then((_) => player.playOrPauseSong());
                  }
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
