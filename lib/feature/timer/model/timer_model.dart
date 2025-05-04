class TimerModel {
  final int? id;
  final int duration;
  final String label;
  final DateTime createdAt;

  TimerModel({
    this.id,
    required this.duration,
    this.label = 'Таймер',
    required this.createdAt
  });

  int get hours => duration ~/ 3600;
  int get minutes => (duration % 3600) ~/ 60;
  int get seconds => duration % 60;

  String get formattedTime {
    return '${hours.toString().padLeft(2, '0')}:'
           '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}';
  }


  Map<String, Object?> toMap(){
    return {
      'duration': duration,
      'label': label,
      'createdAt': createdAt.toIso8601String(),
      };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
  return TimerModel(
    id: map['id'] as int,
    duration : map['duration'] as int,
    label: map['label'] as String,
    createdAt: DateTime.parse(map['createdAt'] as String), // ISO8601
  );  
  }
   @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TimerModel && id == other.id;

  @override
  int get hashCode => id.hashCode;
}