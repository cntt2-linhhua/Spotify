import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopify/core/configs/constants/repeat_mode.dart';
import 'package:shopify/core/configs/assets/app_vectors.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';

class PlayerControls extends StatelessWidget {
  final SongPlayerLoaded playerState;

  const PlayerControls({
    required this.playerState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      builder: (context, playListState) {
        final isLoaded = playListState is PlayListLoaded;
        final isLastSong = isLoaded && playListState.currentIndex >= playListState.songs.length - 1;
        final isFirst = isLoaded && playListState.currentIndex == 0;
        final buttonEnableColor = context.isDarkMode ? AppColors.grey : AppColors.darkGrey;
        final buttonDisableColor = context.isDarkMode ? AppColors.darkGrey : AppColors.grey;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.read<PlayListCubit>().nextRepeatMode();
              },
              icon: SvgPicture.asset(
                AppVectors.loopOrderIcon,
                colorFilter: ColorFilter.mode(
                  (!isLoaded || playListState.repeatMode != RepeatMode.off) ? buttonDisableColor : buttonEnableColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                isFirst ? null : context.read<SongPlayerCubit>().playPreviousSong();
              },
              icon: SvgPicture.asset(
                AppVectors.previousIcon,
                colorFilter: ColorFilter.mode(
                  (!isLoaded || isFirst) ? buttonDisableColor : buttonEnableColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                context.read<SongPlayerCubit>().playOrPauseSong();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(
                  playerState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                isLastSong ? null : context.read<SongPlayerCubit>().playNextSong();
              },
              icon: SvgPicture.asset(
                AppVectors.nextIcon,
                colorFilter: ColorFilter.mode(
                  !isLoaded || isLastSong ? buttonDisableColor : buttonEnableColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                context.read<PlayListCubit>().nextRepeatMode();
              },
              icon: isLoaded && playListState.repeatMode == RepeatMode.one ? Icon(Icons.repeat_one_outlined) : SvgPicture.asset(
                AppVectors.loopIcon,
                colorFilter: ColorFilter.mode(
                  (!isLoaded || isLoaded && playListState.repeatMode == RepeatMode.off )? buttonDisableColor : buttonEnableColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
