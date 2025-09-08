import 'package:flutter/material.dart';
import 'package:shopify/common/widgets/appbar/app_bar.dart';
import 'package:shopify/data/models/artist/artist.dart';
import 'package:shopify/data/sources/artist/artist_fake_service.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/presentation/artists/page/artist_detail.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text(
          'Artists',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
        hideBack: true,
      ),
      body: FutureBuilder<List<Artist>>(
        future: ArtistServiceImpl().getArtists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          final artists = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: _artists(context, artists),
          );
        },
      ),
    );
  }

  Widget _artists(BuildContext context, List<Artist> artists) {
    return GridView.builder(
      itemCount: artists.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArtistDetailPage(artistId: artists[index].id),
            ));
          },
          child: SizedBox(
            width: 160,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.network(
                    artists[index].imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  artists[index].name,
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Color(0xff383838),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: Text(
                    artists[index].bio,
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Color(0xff383838),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
