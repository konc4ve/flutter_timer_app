part of 'recent_timers_overview_bloc.dart';

enum RecentTimersOverviewStatus { initial, loading, success, failure }

final class RecentTimersOverviewState extends Equatable {
  const RecentTimersOverviewState({
    this.status = RecentTimersOverviewStatus.initial,
    this.timers = const [],
  });

  final RecentTimersOverviewStatus status;
  final List<RecentTimerEntity> timers;

  RecentTimersOverviewState copyWith({
    RecentTimersOverviewStatus? status,
    List<RecentTimerEntity>? timers,
  }) {
    return RecentTimersOverviewState(
      status: status ?? this.status,
      timers: timers ?? this.timers,
    );
  }

  @override
  List<Object?> get props => [status, timers];
}