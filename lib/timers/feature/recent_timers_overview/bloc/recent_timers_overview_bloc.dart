import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/data/recent_timers_overview_repository.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/models/recent_timer_entity.dart';

part 'recent_timers_overview_event.dart';
part 'recent_timers_overview_state.dart';

class RecentTimersOverviewBloc
    extends Bloc<RecentTimersOverviewEvent, RecentTimersOverviewState> {
  RecentTimersOverviewBloc(
    RecentTimersOverviewRepository repository,
  )   : _repository = repository,
        super(const RecentTimersOverviewState()) {
    on<RecentTimersOverviewSubscriptionRequested>(
        _onSubscriptionRequested);
    on<RecentTimersOverviewTimerDeleted>(_onTimerDeleted);
  }

  final RecentTimersOverviewRepository _repository;

  Future<void> _onSubscriptionRequested(
    RecentTimersOverviewSubscriptionRequested event,
    Emitter<RecentTimersOverviewState> emit,
  ) async {
    emit(state.copyWith(status: RecentTimersOverviewStatus.loading));
    await emit.forEach(
      _repository.watchTimers(),
      onData: (timers) =>
          state.copyWith(status: RecentTimersOverviewStatus.success, timers: timers),
      onError: (_, __) =>
          state.copyWith(status: RecentTimersOverviewStatus.failure),
    );
  }

  Future<void> _onTimerDeleted(
    RecentTimersOverviewTimerDeleted event,
    Emitter<RecentTimersOverviewState> emit,
  ) async {
    await _repository.deleteRecentTimer(event.timer.id);
  }
}