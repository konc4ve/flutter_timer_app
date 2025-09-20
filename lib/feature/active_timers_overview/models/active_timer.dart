import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/edit_timer/models/models.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';
import 'package:uuid/uuid.dart';

class ActiveTimer extends Equatable {
  ActiveTimer({
    required this.remainDuration,
    String? id,
    required this.duration,
    this.label = '',
  }) : id = id ?? Uuid().v4();

  final String id;
  final Duration duration;
  final String label;
  final Duration remainDuration;

  factory ActiveTimer.fromRecent(RecentTimer timer) {
    return ActiveTimer(
      duration: timer.duration,
      label: timer.label,
      remainDuration: timer.duration,
    );
  }

  factory ActiveTimer.fromEdit(EditTimer timer) {
    return ActiveTimer(
      remainDuration: timer.duration,
      id: timer.id,
      duration: timer.duration,
      label: timer.label,
    );
  }

  @override
  List<Object?> get props => [id, duration, label, remainDuration];

  ActiveTimer copyWith({
    Duration? remainDuration,
    String? id,
    String? label,
    Duration? duration,
  }) {
    return ActiveTimer(
      remainDuration: remainDuration ?? this.remainDuration,
      label: label ?? this.label,
      duration: duration ?? this.duration,
    );
  }
}
