import 'package:flutter/widgets.dart';
import 'package:shopify/common/widgets/favorite_button/favorite_button.dart';
import 'package:shopify/domain/entities/song/song.dart';

class SongDetail extends StatelessWidget {
  final SongEntity song;

  const SongDetail({
    required this.song,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              song.artist,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        FavoriteButton(songId: song.songId),
      ],
    );
  }
}
