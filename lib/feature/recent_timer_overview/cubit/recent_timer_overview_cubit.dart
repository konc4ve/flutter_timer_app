import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/data/data.dart';

part 'recent_timer_overview_state.dart';

class RecentTimerOverviewCubit extends Cubit<RecentTimerOverviewState> {
  RecentTimerOverviewCubit({
    required RecentTimersOverviewRepository recentTimersOverviewRepository,
    required ActiveTimersOverviewRepository activeTimersOverviewRepository,
  }) : _recentTimersOverviewRepository = recentTimersOverviewRepository,
       _activeTimersOverviewRepository = activeTimersOverviewRepository,
       super(RecentTimerOverviewState());

  final RecentTimersOverviewRepository _recentTimersOverviewRepository;

  final ActiveTimersOverviewRepository _activeTimersOverviewRepository;

  Future<void> runActiveTimerFromRecent(String timerId) async {
    final recentTimers = await _recentTimersOverviewRepository
        .getRecentTimers()
        .first;
    final recentTimer = recentTimers.firstWhere((t) => t.id == timerId, orElse: () => throw Exception('Не найден недавний таймер с id $timerId'));
    await _activeTimersOverviewRepository.saveActiveTimer(
      ActiveTimer.fromRecent(recentTimer),
    );
  }
}
