import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/edit_timer/models/models.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';
import 'package:uuid/uuid.dart';

class ActiveTimer extends Equatable{
  ActiveTimer({
    required this.remainingDuration,
    this.label = '',
  });  

  final String id = Uuid().v4();
  final Duration remainingDuration;
  final String label;


  factory ActiveTimer.fromRecent(RecentTimer timer) {
    return ActiveTimer(
      remainingDuration: timer.duration,
      label: timer.label,
      );
  }

  factory ActiveTimer.fromEdit(EditTimer timer) {
    return ActiveTimer(
      remainingDuration: timer.duration,
      label: timer.label,
      );
  }

  @override
  List<Object?> get props => [id, remainingDuration, label];


    ActiveTimer copyWith({
    String? id,
    String? label,
    Duration? remainingDuration,
  }) {
    return ActiveTimer(
      label: label ?? this.label,
      remainingDuration: remainingDuration ?? this.remainingDuration,
      );
  }
}