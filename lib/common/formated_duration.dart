

enum TimerType { active, recent }

sealed class FormatedDuration {
  String format(Duration duration);

  String _formatHMS(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    return '$hours:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  String _formatMS(Duration d) {
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  String _formatMSSimple(Duration d) {
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, "0")}';
  }
}

/// -------------------
/// ActiveTimer
/// -------------------
class ActiveTimerFormatedDuration extends FormatedDuration {
  ActiveTimerFormatedDuration();

  @override
  String format(Duration duration) {
    final d = duration; // предполагаю, что это Duration
    return d.inHours > 0 ? _formatHMS(d) : _formatMS(d);
  }
}

/// -------------------
/// RecentTimer
/// -------------------
class RecentTimerFormatedDuration extends FormatedDuration {
  RecentTimerFormatedDuration();


  @override
  String format(Duration duration) {
    final d = duration;
    if (d.inHours > 0) {
      return _formatHMS(d);
    } else if (d.inMinutes > 0) {
      return _formatMSSimple(d);
    } else {
      return '${d.inSeconds}';
    }
  }
}
