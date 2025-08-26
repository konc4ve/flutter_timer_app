import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_timer_app/feature/edit_timer/models/edit_timer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timers_api/timers_api.dart';
import 'package:uuid/uuid.dart';

part 'recent_timer.g.dart';

@immutable
@JsonSerializable()
class RecentTimer extends Equatable {
  const RecentTimer({
    required this.duration,
    this.label = '',
    required this.id,
  });

  final String id;
  final Duration duration;
  final String label;

  @override
  List<Object?> get props => [id, duration, label];

  RecentTimer copyWith({String? id, String? label, Duration? duration}) {
    return RecentTimer(
      id: id ?? this.id,
      label: label ?? this.label,
      duration: duration ?? this.duration,
    );
  }

  static final Uuid _uuid = Uuid();

  factory RecentTimer.fromEdit(EditTimer timer) {
    return RecentTimer(
      duration: timer.duration,
      id: _uuid.v4(),
      label: timer.label,
    );
  }

  static RecentTimer fromJson(JsonMap json) => _$RecentTimerFromJson(json);

  toJson() => _$RecentTimerToJson(this);
}
