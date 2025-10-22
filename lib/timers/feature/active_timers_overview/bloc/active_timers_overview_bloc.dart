import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/data/active_timers_overview_repository.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';

part 'active_timers_overview_event.dart';
part 'active_timers_overview_state.dart';

class ActiveTimersOverviewBloc
    extends Bloc<ActiveTimersOverviewEvent, ActiveTimersOverviewState> {
  ActiveTimersOverviewBloc(
      ActiveTimersOverviewRepository activeTimersOverviewRepository)
      : _activeTimersOverviewRepository = activeTimersOverviewRepository,
        super(ActiveTimersOverviewState()) {
    on<ActiveTimersOverviewSubscriptionRequested>(
        _onActiveTimersOverviewSubscriptionRequested);
    on<ActiveTimersOverviewTimerDeleted>(_onActiveTimersOverviewTimerDeleted);
  }

  final ActiveTimersOverviewRepository _activeTimersOverviewRepository;

  Future<void> _onActiveTimersOverviewSubscriptionRequested(
      ActiveTimersOverviewSubscriptionRequested event,
      Emitter<ActiveTimersOverviewState> emit) async {
    emit(state.copyWith(status: ActiveTimersOverviewStatus.loading));
    await emit.forEach(
      _activeTimersOverviewRepository.watchTimers(),
      onData: (timers) => state.copyWith(
          activeTimers: timers, status: ActiveTimersOverviewStatus.success),
      onError: (error, stackTrace) =>
          state.copyWith(status: ActiveTimersOverviewStatus.failture),
    );
  }

  Future<void> _onActiveTimersOverviewTimerDeleted(
      ActiveTimersOverviewTimerDeleted event,
      Emitter<ActiveTimersOverviewState> emit) async {
        await _activeTimersOverviewRepository.deleteActiveTimer(event.timer.id);
      }
}
