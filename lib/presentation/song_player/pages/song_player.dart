import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/common/widgets/appbar/app_bar.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/domain/entities/song/song.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';
import 'package:shopify/presentation/song_player/widgets/player_controls.dart';
import 'package:shopify/presentation/song_player/widgets/song_detail.dart';
import 'package:shopify/presentation/song_player/widgets/song_cover.dart';
import 'package:shopify/presentation/song_player/widgets/time_indicator.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;

  const SongPlayerPage({required this.songEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<PlayListCubit>()),
        BlocProvider(
          create: (ctx) {
            final playListCubit = ctx.read<PlayListCubit>();
            final cubit = SongPlayerCubit(playListCubit);
            cubit.loadSong(songEntity);
            return cubit;
          },
        ),
      ],
      child: Scaffold(
        appBar: BasicAppbar(
          title: const Text(
            'Now playing',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          action: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: _SongPlayerBody(),
        ),
      ),
    );
  }
}

class _SongPlayerBody extends StatelessWidget {
  const _SongPlayerBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      buildWhen: (prev, curr) =>
          curr is SongPlayerLoaded || curr is SongPlayerLoading,
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SongPlayerLoaded) {
          final song = state.currentSong;

          return Column(
            children: [
              SongCover(song: song),
              const SizedBox(height: 20),
              SongDetail(song: song),
              const SizedBox(height: 30),
              Slider(
                value: state.songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: state.songDuration.inSeconds.toDouble(),
                onChanged: (value) {
                  context.read<SongPlayerCubit>().seek(
                    Duration(seconds: value.toInt()),
                  );
                },
                activeColor: context.isDarkMode ? AppColors.grey : AppColors.darkGrey,
                thumbColor: context.isDarkMode ? AppColors.darkGrey : AppColors.grey,
              ),
              const SizedBox(height: 20),
              TimeIndicator(state: state),
              const SizedBox(height: 20),
              PlayerControls(playerState: state),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
