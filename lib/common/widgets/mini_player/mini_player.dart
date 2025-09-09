import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      buildWhen: (_, curr) => curr is SongPlayerLoaded,
      builder: (context, state) {
        if (state is! SongPlayerLoaded) return const SizedBox.shrink();

        final song = state.currentSong;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: const Color.fromARGB(255, 110, 56, 36).withOpacity(0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.music_note_outlined),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      song.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      state.isPlaying ? Icons.pause : Icons.play_arrow_outlined,
                      size: 32,
                    ),
                    onPressed: () => context.read<SongPlayerCubit>().playOrPauseSong(),
                  )
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0), // ẩn thumb
                  overlayShape: SliderComponentShape.noOverlay,
                  trackHeight: 2,
                  activeTrackColor: context.isDarkMode ? AppColors.grey : AppColors.darkGrey,
                  inactiveTrackColor: context.isDarkMode
                      ? AppColors.darkGrey.withOpacity(0.5)
                      : AppColors.grey.withOpacity(0.5),
                ),
                child: Slider(
                  value: state.songPosition.inSeconds.clamp(0, state.songDuration.inSeconds).toDouble(),
                  min: 0,
                  max: state.songDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    context.read<SongPlayerCubit>().seek(
                      Duration(seconds: value.toInt()),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
