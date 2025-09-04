import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/common/widgets/appbar/app_bar.dart';
import 'package:shopify/core/configs/constants/app_urls.dart';
import 'package:shopify/domain/entities/song/song.dart';
import 'package:shopify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:shopify/presentation/home/bloc/news_songs_state.dart';
import 'package:shopify/presentation/song_player/pages/song_player.dart';

class ArtistsPage extends StatelessWidget {

  const ArtistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: Scaffold(
        appBar: BasicAppbar(
          title: const Text(
            'Artists',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          action: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator()
                );
            }

            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }

            return Container();
          },
        ),
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return GridView.builder(
          itemCount: songs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cột
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
            childAspectRatio: 0.95, // tỷ lệ width/height
          ),
          itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => SongPlayerPage(songEntity: songs[index]))
            );
          },
          child: SizedBox(
            width: 160,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.network(
                    '${AppUrls.coverStorage}${songs[index].artist}.jpg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  songs[index].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
