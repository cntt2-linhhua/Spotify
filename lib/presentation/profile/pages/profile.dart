import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/common/widgets/appbar/app_bar.dart';
import 'package:shopify/common/widgets/favorite_button/favorite_button.dart';
import 'package:shopify/core/configs/constants/app_urls.dart';
import 'package:shopify/presentation/home/bloc/play_list_cubit.dart';
import 'package:shopify/presentation/favorite/bloc/favorite_songs_cubit.dart';
import 'package:shopify/presentation/favorite/bloc/favorite_songs_state.dart';
import 'package:shopify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:shopify/presentation/profile/bloc/profile_info_state.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:shopify/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileInfoCubit()..getUser()),
        // BlocProvider(create: (_) => FavoriteSongsCubit()..getFavoriteSongs()),
        BlocProvider(
          create: (ctx) => FavoriteSongsCubit(ctx.read<PlayListCubit>(), ctx.read<SongPlayerCubit>(),),
        ),
      ],
      child: Scaffold(
        appBar: BasicAppbar(
          title: Text('Profile'),
          backgroundColor: context.isDarkMode ? Color(0xff2c2b2b) : Colors.white,
          hideBack: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileInfo(context),
            SizedBox(height: 30),
            _favoriteSongs(),
          ]
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Color(0xff2c2b2b) : Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
    
          if (state is ProfileInfoLoaded) {
            return Column(
              children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.userEntity.imageURL!),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(state.userEntity.email!),
                SizedBox(height: 10),
                Text(
                  state.userEntity.fullName!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            );
          }
    
          if (state is ProfileInfoFailure) {
            return Container(
              alignment: Alignment.center,
              child: Text('Please try again'),
            );
          }
    
          return Container();
        },
      ),
    );
  }

  Widget _favoriteSongs() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FAVORITE SONGS'
          ),
          SizedBox(height: 20),
          BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
            builder: (context, state) {
              if (state is FavoriteSongsLoading) {
                return CircularProgressIndicator();
              }
      
              if (state is FavoriteSongsLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SongPlayerPage(songEntity: state.favoriteSongs[index])
                          )
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppUrls.coverStorage}${state.favoriteSongs[index].artist}.jpg'
                                    )
                                  )
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      state.favoriteSongs[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      state.favoriteSongs[index].artist,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                state.favoriteSongs[index].duration.toString().replaceAll('.', ':')
                              ),
                              const SizedBox(width: 20),
                              FavoriteButton(
                                songId: state.favoriteSongs[index].songId,
                                key: UniqueKey(),
                                onToggle: () {
                                  context.read<FavoriteSongsCubit>().removeSong(state.favoriteSongs[index].songId);
                                },
                                
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: state.favoriteSongs.length
                );
              }
      
              if (state is FavoriteSongsFailure) {
                return Text('Please try again.');
              }
      
              return Container();
            },
          )
        ],
      ),
    );
  }
}
