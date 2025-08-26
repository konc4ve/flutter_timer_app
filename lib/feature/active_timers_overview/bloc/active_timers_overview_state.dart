part of 'active_timers_overview_bloc.dart';

enum ActiveTimersOverviewStatus {
  initial,
  loading,
  success,
  failture
}

final class ActiveTimersOverviewState extends Equatable {
  const ActiveTimersOverviewState({
    this.status = ActiveTimersOverviewStatus.initial,
    this.activeTimers = const [],
  });
  
  final ActiveTimersOverviewStatus status;
  final List<ActiveTimer> activeTimers;


  @override
  List<Object> get props => [status, activeTimers];

  ActiveTimersOverviewState copyWith({
    ActiveTimersOverviewStatus? status,
    List<ActiveTimer>? activeTimers,
})
  {
    return ActiveTimersOverviewState(
      status: status ?? this.status,
      activeTimers: activeTimers ?? this.activeTimers,
    );
  }
}

