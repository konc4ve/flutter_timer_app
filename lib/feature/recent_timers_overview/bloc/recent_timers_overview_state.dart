part of 'recent_timers_overview_bloc.dart';

enum RecentTimersOverviewStatus {
  initial,
  loading,
  success,
  failture
}

final class RecentTimersOverviewState extends Equatable {
  const RecentTimersOverviewState({
    this.status = RecentTimersOverviewStatus.initial,
    this.recentTimers = const [],
  });
  
  final RecentTimersOverviewStatus status;
  final List<RecentTimer> recentTimers;


  @override
  List<Object> get props => [status, recentTimers];

  RecentTimersOverviewState copyWith({
    RecentTimersOverviewStatus? status,
    List<RecentTimer>? recentTimers,
})
  {
    return RecentTimersOverviewState(
      status: status ?? this.status,
      recentTimers: recentTimers ?? this.recentTimers,
    );
  }
}

