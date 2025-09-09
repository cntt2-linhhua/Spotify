import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/common/widgets/appbar/app_bar.dart';
import 'package:shopify/presentation/favorite/widgets/favorite_list.dart';
import 'package:shopify/presentation/favorite/widgets/top_bar.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  void _onPlayAllTap(BuildContext context) {
    final playlistState = context.read<PlayListCubit>().state;
    if (playlistState is! PlayListLoaded) return;

    final favorites = playlistState.songs.where((s) => s.isFavorite).toList();
    if (favorites.isEmpty) return;

    final player = context.read<SongPlayerCubit>();
    final playerState = player.state;

    final isCurrentFavorite = playerState is SongPlayerLoaded &&
        favorites.any((s) => s.songId == playerState.currentSong.songId);

    if (isCurrentFavorite) {
      player.playOrPauseSong();
    } else {
      final first = favorites.first;
      player.loadSong(first).then((_) => player.playOrPauseSong());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: const Text("Favorites"), hideBack: true),
      body: Column(
        children: [
          TopBar(onPlayAllTap: () => _onPlayAllTap(context)),
          const Expanded(child: FavoriteList()),
        ],
      ),
    );
  }
}
