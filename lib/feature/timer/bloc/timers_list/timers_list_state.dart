part of 'timers_list_bloc.dart';

sealed class TimersListState extends Equatable {
  const TimersListState();
  
  @override
  List<Object> get props => [];
}

final class TimersListInitial extends TimersListState {}

final class LoadTimersListInProgress extends TimersListState {
  const LoadTimersListInProgress();
}

final class LoadTimersListSuccess extends TimersListState {
  final List<TimerModel> timersList;
  const LoadTimersListSuccess({required this.timersList});
}

final class LoadTimersListFailure extends TimersListState {
  final String error;
  const LoadTimersListFailure({required this.error});
}


final class AddTimerInProgress extends TimersListState {
  const AddTimerInProgress();
}

final class AddTimerSuccess extends TimersListState {
  const AddTimerSuccess();
}

final class AddTimerFailure extends TimersListState {
  final String error;
  const AddTimerFailure({required this.error});
}
