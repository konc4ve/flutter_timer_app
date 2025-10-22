import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/models/edit_timer.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/models/recent_timer_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:flutter_timer_app/core/database/database.dart';

enum AlarmMelody {
  defaultMelody('WHATCH OUT!', 'homixide_gang_watch_out.mp3'),
  succubus('Succubus', 'succubus.mp3'),
  popout('POP OUT!', 'pop_out.mp3');
  final String name;
  final String filename;
  const AlarmMelody(this.name, this.filename);
}

class ActiveTimerEntity extends Equatable {
  ActiveTimerEntity({
    this.alarmMelody = AlarmMelody.defaultMelody,
    required this.setDuration,
    Duration? remainDuration,
    this.isRunning = true,
    this.label = '',
    String? id,
  }) : id = id ?? _uuid.v4(),
       remainDuration = remainDuration ?? setDuration;

  final AlarmMelody alarmMelody;
  final String id;
  final bool isRunning;
  final Duration remainDuration;
  final Duration setDuration;
  final String label;

  static final Uuid _uuid = Uuid();

  @override
  List<Object?> get props => [
    id,
    setDuration,
    remainDuration,
    label,
    isRunning,
    alarmMelody,
  ];

  ActiveTimerEntity copyWith({
    AlarmMelody? alarmMelody,
    String? id,
    String? label,
    Duration? setDuration,
    Duration? remainDuration,
    bool? isRunning,
  }) {
    return ActiveTimerEntity(
      alarmMelody: alarmMelody ?? this.alarmMelody,
      id: id ?? this.id,
      label: label ?? this.label,
      setDuration: setDuration ?? this.setDuration,
      remainDuration: remainDuration ?? this.remainDuration,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  factory ActiveTimerEntity.fromEdit(EditTimer timer) {
    return ActiveTimerEntity(
      alarmMelody: timer.alarmMelody,
      id: timer.id,
      setDuration: timer.duration,
      label: timer.label,
      remainDuration: timer.duration,
    );
  }

  factory ActiveTimerEntity.fromRecent(RecentTimerEntity timer) {
    return ActiveTimerEntity(
      alarmMelody: timer.alarmMelody,
      setDuration: timer.setDuration,
      label: timer.label,
    );
  }

  /// Создание бизнес-модели из Drift-модели
  factory ActiveTimerEntity.fromDb(ActiveTimer dbTimer) {
    final melody = AlarmMelody.values.firstWhere(
      (melody) => melody.filename == dbTimer.alarmMelody,
      orElse: () => AlarmMelody.defaultMelody,
    );

    return ActiveTimerEntity(
      alarmMelody: melody,
      id: dbTimer.id,
      label: dbTimer.label,
      isRunning: dbTimer.isRunning,
      remainDuration: dbTimer.remainDuration,
      setDuration: dbTimer.setDuration,
    );
  }

  /// Для вставки в базу
  ActiveTimersCompanion toInsertCompanion() {
    return ActiveTimersCompanion.insert(
      alarmMelody: alarmMelody.filename,
      id: id,
      label: label,
      isRunning: isRunning,
      remainDuration: remainDuration,
      setDuration: setDuration,
    );
  }

  /// Для обновления в базе
  ActiveTimersCompanion toUpdateCompanion() {
    return ActiveTimersCompanion(
      alarmMelody: Value(alarmMelody.filename),
      id: Value(id),
      label: Value(label),
      isRunning: Value(isRunning),
      remainDuration: Value(remainDuration),
      setDuration: Value(setDuration),
    );
  }
}
