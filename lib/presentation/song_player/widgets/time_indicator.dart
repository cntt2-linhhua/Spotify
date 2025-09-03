import 'package:flutter/widgets.dart';
import 'package:shopify/common/helpers/time.dart';
import 'package:shopify/presentation/song_player/bloc/song_player_state.dart';

class TimeIndicator extends StatelessWidget {
  final SongPlayerLoaded state;

  const TimeIndicator({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(formatDuration(state.songPosition)),
        Text(formatDuration(state.songDuration)),
      ],
    );
  }
}
