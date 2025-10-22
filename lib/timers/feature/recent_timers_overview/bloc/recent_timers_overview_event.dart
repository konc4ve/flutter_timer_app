

part of 'recent_timers_overview_bloc.dart';


sealed class RecentTimersOverviewEvent extends Equatable {
  const RecentTimersOverviewEvent();

  @override
  List<Object?> get props => [];
}

final class RecentTimersOverviewSubscriptionRequested
    extends RecentTimersOverviewEvent {
  const RecentTimersOverviewSubscriptionRequested();
}

final class RecentTimersOverviewTimerDeleted
    extends RecentTimersOverviewEvent {
  const RecentTimersOverviewTimerDeleted(this.timer);

  final RecentTimerEntity timer;

  @override
  List<Object?> get props => [timer];
}