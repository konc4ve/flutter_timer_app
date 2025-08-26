import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/data/data.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/models/recent_timer.dart';

part 'recent_timers_overview_event.dart';
part 'recent_timers_overview_state.dart';

class RecentTimersOverviewBloc extends Bloc<RecentTimersOverviewEvent, RecentTimersOverviewState> {
  RecentTimersOverviewBloc({required RecentTimersOverviewRepository resentTimersRepository})
   : _recentTimersRepository = resentTimersRepository, super(const RecentTimersOverviewState()) {
    on<RecentTimersOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<RecentTimersOverviewTimerDeleted>(_onTimerDeleted);
  } 

  final RecentTimersOverviewRepository _recentTimersRepository;
  
  Future<void> _onSubscriptionRequested(RecentTimersOverviewSubscriptionRequested event, Emitter<RecentTimersOverviewState> emit) async {
    emit(state.copyWith(status: RecentTimersOverviewStatus.loading));

    await emit.forEach(
    _recentTimersRepository.getRecentTimers(),
    onData: (timers) => state.copyWith(recentTimers: timers, status: RecentTimersOverviewStatus.success),
    onError: (error, stackTrace) => state.copyWith(status: RecentTimersOverviewStatus.failture)
    );
  }

    Future<void> _onTimerDeleted(RecentTimersOverviewTimerDeleted event, Emitter<RecentTimersOverviewState> emit) async {
      await _recentTimersRepository.deleteRecentTimer(event.timer.id);
    }

}
