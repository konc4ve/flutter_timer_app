// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timer _$TimerFromJson(Map<String, dynamic> json) => Timer(
  duration: Duration(microseconds: (json['duration'] as num).toInt()),
  id: json['id'] as String?,
  label: json['label'] as String,
);

Map<String, dynamic> _$TimerToJson(Timer instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'duration': instance.duration.inMicroseconds,
};
