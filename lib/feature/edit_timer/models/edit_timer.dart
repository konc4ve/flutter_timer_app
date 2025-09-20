import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:uuid/uuid.dart';

class EditTimer {
  EditTimer({String? id, this.label = '', this.duration = Duration.zero})
    : id = id ?? const Uuid().v4();

  final String id;
  final String label;
  final Duration duration;

  EditTimer copyWith({String? id, Duration? duration, String? label}) {
    return EditTimer(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      label: label ?? this.label,
    );
  }

  factory EditTimer.fromActive(ActiveTimer timer) {
    return EditTimer(
      id: timer.id, // <-- сохраняем ID!
      duration: timer.duration,
      label: timer.label,
    );
  }
}
