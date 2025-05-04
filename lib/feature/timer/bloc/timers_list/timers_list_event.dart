part of 'timers_list_bloc.dart';

sealed class TimersListEvent extends Equatable {
  const TimersListEvent();

  @override
  List<Object> get props => [];
}

class LoadTimersList extends TimersListEvent {
  const LoadTimersList();
}

class AddTimer extends TimersListEvent {
  final int duration;
  const AddTimer({required this.duration});
}