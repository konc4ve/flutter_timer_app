class TimerModel {
  final String id;
  final int duration;
  final String label;
  final DateTime createdAt;

  TimerModel({
    required this.id,
    required this.duration,
    required this.label ,
    required this.createdAt
  });

  String get formatedDuration {
    final hour = duration ~/ 3600;
    final min = (duration % 3600) ~/ 60;
    final sec = duration % 60;
    return '${hour.toString().padLeft(2, '0')}:'
          '${min.toString().padLeft(2, '0')}:'
          '${sec.toString().padLeft(2, '0')}';
  }

  Map<String, Object?> toMap(){
    return {
      'id':id,
      'duration': duration,
      'label': label,
      'createdAt': createdAt.toIso8601String(),
      };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
  return TimerModel(
    id: map['id'].toString(),
    duration : map['duration'] as int,
    label: map['label'] as String,
    createdAt: DateTime.parse(map['createdAt'] as String), // ISO8601
  );  
  }

  TimerModel copyWith({required id}) {
    return TimerModel(duration: duration, createdAt: createdAt, id: id, label: label);
  }
  @override
bool operator ==(Object other) {
  return other is TimerModel && other.id == id;
}

@override
int get hashCode => id.hashCode;

}