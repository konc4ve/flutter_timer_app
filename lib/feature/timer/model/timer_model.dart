class TimerModel {
  final String id;
  final Duration duration;
  final String label;
  final DateTime createdAt;

  TimerModel({
    required this.id,
    required this.duration,
    required this.label ,
    required this.createdAt
  });

  Map<String, Object?> toMap(){
    return {
      'id':id,
      'duration': duration.inSeconds,
      'label': label,
      'createdAt': createdAt.toIso8601String(),
      };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
  return TimerModel(
    id: map['id'].toString(),
    duration : Duration(seconds: map['duration'] as int),
    label: map['label'] as String,
    createdAt: DateTime.parse(map['createdAt'] as String), 
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