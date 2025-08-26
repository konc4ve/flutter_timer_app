part of 'edit_timer_bloc.dart';

enum EditTimerStatus {initial, loading, success, failture, duplicate}


final class EditTimerState extends Equatable {
  const EditTimerState(
    {
      this.status = EditTimerStatus.initial,
      this.duration = Duration.zero,
      this.label = '',
      this.initialTimer
    }
  );
  
  final EditTimerStatus status;
  final EditTimer? initialTimer;
  final String label;
  final Duration duration;


  bool get isNewtimer => initialTimer == null;


  EditTimerState copyWith({
    String? label,
    EditTimerStatus? status,
    Duration? duration,
    EditTimer? initialTimer,
  }) {
    return EditTimerState(
      duration: duration ?? this.duration,
      label: label ?? this.label,
      initialTimer: initialTimer ?? this.initialTimer,
      status: status ?? this.status,
      );
  }

  @override
  List<Object> get props => [label, duration];
}

