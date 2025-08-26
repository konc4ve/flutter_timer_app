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

final class EditTimerSubmitted extends EditTimerEvent {
  const EditTimerSubmitted();

}


