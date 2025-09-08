import 'package:flutter/material.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/common/helpers/time.dart';
import 'package:shopify/common/widgets/favorite_button/favorite_button.dart';
import 'package:shopify/core/configs/theme/app_color.dart';
import 'package:shopify/data/models/song/song_2.dart';

class SongItem extends StatelessWidget {
  final SongV2 song;
  final VoidCallback? onTap;

  const SongItem({
    super.key,
    required this.song,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Left: Play button + title + artist
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode ? AppColors.darkGrey : const Color(0xffE6E6E6),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      song.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 5),
                  // SizedBox(
                  //   width: 150,
                  //   child: Text(
                  //     song.artist,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: const TextStyle(
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),

          /// Right: Duration + FavoriteButton
          Row(
            children: [
              Text(convertNumToTime(song.duration)),
              const SizedBox(width: 20),
              FavoriteButton(songId: song.id),
            ],
          )
        ],
      ),
    );
  }
}
