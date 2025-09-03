import 'package:flutter/widgets.dart';
import 'package:shopify/core/configs/constants/app_urls.dart';
import 'package:shopify/domain/entities/song/song.dart';

class SongCover extends StatelessWidget {
  final SongEntity song;

  const SongCover({
    required this.song,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage('${AppUrls.coverStorage}${song.artist}.jpg'),
        ),
      ),
    );
  }
}