import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/models/edit_timer.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:flutter_timer_app/core/database/database.dart';

class RecentTimerEntity extends Equatable {
  RecentTimerEntity({
    this.alarmMelody = AlarmMelody.defaultMelody,
    required this.setDuration,
    this.label = '',
    String? id,
  }) : id = id ?? _uuid.v4();

  final AlarmMelody alarmMelody;
  final String id;
  final Duration setDuration;
  final String label;

  static final Uuid _uuid = Uuid();

  @override
  List<Object?> get props => [id, setDuration, label, alarmMelody];

  factory RecentTimerEntity.fromEdit(EditTimer timer) {
    return RecentTimerEntity(
      alarmMelody: timer.alarmMelody,
      setDuration: timer.duration,
      label: timer.label,
      id: timer.id,
    );
  }

  // RecentTimerEntity copyWith({
  //   String? id,
  //   String? label,
  //   Duration? setDuration,
  // }) {
  //   return RecentTimerEntity(
  //     id: id ?? this.id,
  //     label: label ?? this.label,
  //     setDuration: setDuration ?? this.setDuration,
  //   );
  // }

  /// Drift → Entity
  factory RecentTimerEntity.fromDb(RecentTimer dbTimer) {
    final melody = AlarmMelody.values.firstWhere(
      (melody) => melody.filename == dbTimer.alarmMelody,
      orElse: () => AlarmMelody.defaultMelody,
    );

    return RecentTimerEntity(
      alarmMelody: melody,
      id: dbTimer.id,
      label: dbTimer.label,
      setDuration: dbTimer.setDuration,
    );
  }

  /// Для INSERT
  RecentTimersCompanion toInsertCompanion() {
    return RecentTimersCompanion.insert(
      alarmMelody: alarmMelody.filename,
      id: id,
      label: label,
      setDuration: setDuration,
    );
  }

  /// Для UPDATE
  RecentTimersCompanion toUpdateCompanion() {
    return RecentTimersCompanion(
      alarmMelody: Value(alarmMelody.filename),
      id: Value(id),
      label: Value(label),
      setDuration: Value(setDuration),
    );
  }
}
