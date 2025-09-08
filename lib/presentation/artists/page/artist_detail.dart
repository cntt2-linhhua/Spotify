import 'package:flutter/material.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/common/widgets/song_item/song_item.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/data/models/album/album.dart';
import 'package:shopify/data/models/artist/artist.dart';
import 'package:shopify/data/models/song/song_2.dart';
import 'package:shopify/data/sources/album/album_fake_service.dart';
import 'package:shopify/data/sources/artist/artist_fake_service.dart';
import 'package:shopify/data/sources/song/song_fake_service.dart';

class ArtistDetailPage extends StatefulWidget {
  final String artistId;

  const ArtistDetailPage({super.key, required this.artistId});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  late Future<Artist> artistFuture;
  late Future<List<Album>> albumFuture;
  late Future<List<SongV2>> songFuture;

  @override
  void initState() {
    super.initState();
    artistFuture = ArtistServiceImpl().getArtistById(widget.artistId);
    albumFuture = AlbumServiceImpl().getAlbumsByArtist(widget.artistId);
    songFuture = SongServiceImpl().getSongsByArtist(widget.artistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Artist>(
        future: artistFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final artist = snapshot.data!;

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  expandedHeight: 250,
                  backgroundColor: context.isDarkMode
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.network(
                        artist.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Artist info
                Text(
                  artist.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "2 Album , 2 Track",
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  artist.bio,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Albums
                const Text("Albums",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                FutureBuilder<List<Album>>(
                  future: albumFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2));
                    }
                    final albums = snapshot.data!;
                    return SizedBox(
                      height: 160,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: albums.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final album = albums[index];
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  album.coverUrl,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  album.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Songs
                const Text("Songs",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                FutureBuilder<List<SongV2>>(
                  future: songFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2));
                    }
                    final songs = snapshot.data!;
                    return Column(
                      children: songs.map((song) {
                        return SongItem(
                          song: song,
                          onTap: () {
                            // mở player
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
