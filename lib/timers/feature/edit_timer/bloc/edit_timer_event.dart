part of 'edit_timer_bloc.dart';

sealed class EditTimerEvent extends Equatable {
  const EditTimerEvent();

  @override
  List<Object> get props => [];
}

final class EditTimerLabelChanged extends EditTimerEvent {
  const EditTimerLabelChanged(this.label);

  final String label;

  @override
  List<Object> get props => [label];
}

final class EditTimerDurationChanged extends EditTimerEvent {
  const EditTimerDurationChanged(this.duration);

  final Duration duration;

  @override
  List<Object> get props => [duration];
}

final class EditTimerMelodyChanged extends EditTimerEvent {
  const EditTimerMelodyChanged(this.melody);

  final AlarmMelody melody;
  @override
  List<Object> get props => [melody];
}

final class EditTimerSubmitted extends EditTimerEvent {
  const EditTimerSubmitted();
}

final class EditTimerReset extends EditTimerEvent {
  const EditTimerReset();

  @override
  List<Object> get props => [];
}
