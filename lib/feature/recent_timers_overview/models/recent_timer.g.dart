// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentTimer _$RecentTimerFromJson(Map<String, dynamic> json) => RecentTimer(
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      label: json['label'] as String? ?? '',
      id: json['id'] as String,
    );

Map<String, dynamic> _$RecentTimerToJson(RecentTimer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration.inMicroseconds,
      'label': instance.label,
    };
