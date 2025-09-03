import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/common/helpers/time.dart';
import 'package:shopify/common/widgets/favorite_button/favorite_button.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/domain/entities/song/song.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/home/bloc/play_list_state.dart';
import 'package:shopify/presentation/song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayListCubit, PlayListState>(
      listener: (context, state) {
        debugPrint('[PlayList widget] new state: $state');
      },
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator()
              );
          }
      
          if (state is PlayListLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Playlist',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      'See more',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: context.isDarkMode ? Color(0xffc6c6c6) : Color(0xff131313),
                      ),
                    ),
                  ],
                ),
                _songs(state.songs),
              ],
            );
          }
      
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          key: ValueKey(songs[index].songId),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => SongPlayerPage(songEntity: songs[index]))
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode ? AppColors.darkGrey : Color(0xffE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode ? Color(0xff959595) : Color(0xff555555),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          songs[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 150,
                        child: Text(
                          songs[index].artist,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(formatNumToDuration(songs[index].duration)),
                  SizedBox(width: 20),
                  FavoriteButton(songId: songs[index].songId)
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: songs.length,
    );
  }
}