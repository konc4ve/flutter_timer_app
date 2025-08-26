part of 'active_timers_overview_bloc.dart';

sealed class ActiveTimersOverviewEvent extends Equatable {
  const ActiveTimersOverviewEvent();

  @override
  List<Object> get props => [];
}

final class ActiveTimersOverviewSubscriptionRequested extends ActiveTimersOverviewEvent {
  const ActiveTimersOverviewSubscriptionRequested();
}

final class ActiveTimersOverviewTimerDeleted extends ActiveTimersOverviewEvent {

  const ActiveTimersOverviewTimerDeleted({required this.timer});

  final ActiveTimer timer;

    @override
  List<Object> get props => [timer];
}