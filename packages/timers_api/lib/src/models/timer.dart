import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timers_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';


part 'timer.g.dart';

@immutable
@JsonSerializable()

class Timer extends Equatable{
  
  final String id;
  final String label;
  final Duration duration;

  Timer(
    {
    required this.duration,
    String? id,
    this.label = '',
    }) : assert(
      id == null || id.isNotEmpty,
      'id must either be null or not empty'
    ), 
    id = id ?? Uuid().v4();



  Timer copyWith({
    String? id,
    String? label,
    Duration? duration,
  }) {
    return Timer(
      id: id ?? this.id,
      label: label ?? this.label,
      duration: duration ?? this.duration,
      );
  }


  static Timer fromJson(JsonMap json) => _$TimerFromJson(json);

  toJson() => _$TimerToJson(this);

    @override
  List<Object?> get props => [id, label, duration];
}