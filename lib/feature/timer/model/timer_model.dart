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

  TimerModel copyWith({required id}) {
    return TimerModel(duration: duration, createdAt: createdAt, id: id);
  }
  @override
bool operator ==(Object other) {
  return other is TimerModel && other.id == id;
}

@override
int get hashCode => id.hashCode;

}