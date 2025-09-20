String formatLabelFromDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  final parts = <String>[];

  if (hours > 0) parts.add('$hours ч');
  if (minutes > 0) parts.add('$minutes мин');
  if (seconds > 0 || parts.isEmpty) parts.add('$seconds с');

  return parts.join(', ');
}