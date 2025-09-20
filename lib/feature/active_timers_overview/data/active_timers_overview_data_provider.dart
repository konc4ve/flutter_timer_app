import 'package:flutter_timer_app/feature/active_timers_overview/data/active_timers_overview_repository.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/models/models.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class ActiveTimersOverviewDataProvider {
  Stream<List<ActiveTimer>> getActiveTimers();

  Future<void> saveActiveTimer(ActiveTimer timer);

  Future<void> upDateActiveTimer(ActiveTimer updatedTimer);

  Future<void> deleteActiveTimer(String id);

  Future<void> close();
}

class ActiveTimersOverviewDataProviderImpl
    implements ActiveTimersOverviewDataProvider {
  ActiveTimersOverviewDataProviderImpl();

  @override
  Stream<List<ActiveTimer>> getActiveTimers() =>
      _timerStreamController.asBroadcastStream();

  final _timerStreamController = BehaviorSubject<List<ActiveTimer>>.seeded(
    const [],
  );

  @override
  Future<void> deleteActiveTimer(String id) async {
    final timers = [..._timerStreamController.value];
    final timerIndex = timers.indexWhere((t) => t.id == id);
    if (timerIndex == -1) {
      throw ActiveTimerNotFoundException();
    } else {
      timers.removeAt(timerIndex);
      _timerStreamController.add(timers);
    }
  }

  @override
  Future<void> saveActiveTimer(ActiveTimer timer) async {
    final timers = [..._timerStreamController.value];
    final timerIndex = timers.indexWhere((t) => t.id == timer.id);
    if (timerIndex >= 0) {
      timers[timerIndex] = timer;
    } else {
      timers.add(timer);
    }
    _timerStreamController.add(timers);
  }

  @override
  Future<void> close() {
    return _timerStreamController.close();
  }

  @override
  Future<void> upDateActiveTimer(ActiveTimer updatedTimer) async {
    final timers = [..._timerStreamController.value];
    final index = timers.indexWhere((t) => t.id == updatedTimer.id);
    if (index != -1) {
      timers[index] = updatedTimer;
      _timerStreamController.value = timers;
    } else {
      throw ActiveTimerNotFoundException();
    }
  }
}
