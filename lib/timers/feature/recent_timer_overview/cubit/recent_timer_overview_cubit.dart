import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/models/recent_timer_entity.dart';

part 'recent_timer_overview_state.dart';

class RecentTimerOverviewCubit extends Cubit<RecentTimerOverviewState> {
  RecentTimerOverviewCubit({
    required RecentTimerEntity recentTimerEntity,
    required ActiveTimersOverviewRepository activeTimersOverviewRepository,
  }) : _activeTimersOverviewRepository = activeTimersOverviewRepository,
       _recentTimerEntity = recentTimerEntity,
       super(RecentTimerOverviewState());

  final RecentTimerEntity _recentTimerEntity;

  final ActiveTimersOverviewRepository _activeTimersOverviewRepository;

  Future<void> runActiveTimerFromRecent(String timerId) async {
    await _activeTimersOverviewRepository.saveActiveTimer(
      ActiveTimerEntity.fromRecent(_recentTimerEntity),
    );
  }
}
