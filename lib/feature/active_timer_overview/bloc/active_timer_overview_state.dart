part of 'active_timer_overview_bloc.dart';

sealed class ActiveTimerOverviewState extends Equatable {
  const ActiveTimerOverviewState(this.duration);
  final Duration duration;

  @override
  List<Object> get props => [duration];
}

final class ActiveTimerOverviewInitial extends ActiveTimerOverviewState {
  const ActiveTimerOverviewInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

final class ActiveTimerOverviewRunPause extends ActiveTimerOverviewState {
  const ActiveTimerOverviewRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

final class ActiveTimerOverviewRunInProgress extends ActiveTimerOverviewState {
  const ActiveTimerOverviewRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

final class ActiveTimerOverviewRunComplete extends ActiveTimerOverviewState {
  const ActiveTimerOverviewRunComplete() : super(Duration.zero);
}