String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

String formatNumToDuration(num time) {
  final minutes = time.truncate();
  final seconds = time.toString().split('.')[1];
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padRight(2, '0')}';
}

String convertNumToTime(int time) {
  final duration = Duration(seconds: time);
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final secs = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$secs";
}
  