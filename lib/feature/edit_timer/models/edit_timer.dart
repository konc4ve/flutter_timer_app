class EditTimer {
  EditTimer({this.label = '', this.duration = Duration.zero});

  final String label;
  final Duration duration;

  EditTimer copyWith({Duration? duration, String? label}) {
    return EditTimer(
      duration: duration ?? this.duration,
      label: label ?? this.label,
    );
  }
}
