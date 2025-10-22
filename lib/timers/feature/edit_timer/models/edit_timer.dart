import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:uuid/uuid.dart';

class EditTimer {
  EditTimer({
    this.alarmMelody = AlarmMelody.defaultMelody,
    String? id,
    this.label = '',
    this.duration = Duration.zero,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String label;
  final Duration duration;
  final AlarmMelody alarmMelody;

  EditTimer copyWith({
    AlarmMelody? alarmMelody,
    String? id,
    Duration? duration,
    String? label,
  }) {
    return EditTimer(
      alarmMelody: alarmMelody ?? this.alarmMelody,
      id: id ?? this.id,
      duration: duration ?? this.duration,
      label: label ?? this.label,
    );
  }

  factory EditTimer.fromActive(ActiveTimerEntity timer) {
    return EditTimer(
      alarmMelody: timer.alarmMelody,
      id: timer.id, // <-- сохраняем ID!
      duration: timer.remainDuration,
      label: timer.label,
    );
  }
}
