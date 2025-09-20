import 'package:flutter_timer_app/feature/active_timer_overview/timer_overview.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ActiveTimersBlocManager {
  ActiveTimersBlocManager({required ActiveTimersOverviewRepository repository})
    : _repository = repository;

  final Map<String, ActiveTimerOverviewBloc> _blocs = {};

  final ActiveTimersOverviewRepository _repository;

  void dispose(String tID) {
    final bloc = _blocs[tID];
    if (bloc != null) {
      bloc.close();
      _blocs.remove(tID);
    }
  }

  ActiveTimerOverviewBloc getBlocForTimer(ActiveTimer timer) {
    return _blocs.putIfAbsent(
      timer.id,
      () => ActiveTimerOverviewBloc(
        manager: this,
        activeTimersOverviewRepository: _repository,
        timer: timer,
        stopWatchTimer: StopWatchTimer(
          mode: StopWatchMode.countDown,
          presetMillisecond: timer.duration.inMilliseconds,
        ),
      )..add(ActiveTimerStarted()),
    );
  }
}
