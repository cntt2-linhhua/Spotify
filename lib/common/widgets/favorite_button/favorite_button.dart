import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/domain/entities/song/song.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';

class FavoriteButton extends StatelessWidget {
  final String songId;
  final VoidCallback? onToggle;

  const FavoriteButton({
    super.key,
    required this.songId,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PlayListCubit, PlayListState, SongEntity?>(
      selector: (state) {
        if (state is PlayListLoaded) {
          return state.songs.firstWhere(
            (s) => s.songId == songId,
            orElse: () => SongEntity(
              songId: songId,
              title: '',
              artist: '',
              duration: 0,
              releaseDate: Timestamp.now(),
              isFavorite: false,
            ),
          );
        }
        return null;
      },
      builder: (context, song) {
        if (song == null) {
          return const SizedBox.shrink();
        }

        return IconButton(
          icon: Icon(
            song.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: song.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            context.read<PlayListCubit>().toggleFavorite(song.songId);
            if (onToggle != null) {
              onToggle!();
            }
          },
        );
      },
    );
  }
}

