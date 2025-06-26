import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/timers_bloc_manager.dart';

class TimerManager {
  TimerRecentListNotifier resentNotifier;
  TimerActiveListNotifier activeNotifier;
  TimerDatabase db;
  TimersBlocManager blocManager;
  TimerManager({required this.activeNotifier, required this.resentNotifier, required this.db, required this.blocManager});


Future<void> createAndRunTimer({required TimerModel timer, required bool saveToDb}) async {
  if (saveToDb) {
    await db.insertTimer(timer);
    resentNotifier.addTimer(timer);
  }
  final activeTimer = activeNotifier.createFromTemplate(timer);
  final bloc = blocManager.getBloc(activeTimer);
  bloc.add(TimerStarted(duration: timer.duration));
}
  

  Future<void> removeRecentTimer(TimerModel timer) async {
    await db.deleteTimer(timer);
    resentNotifier.removeTimer(timer);
  }

  Future<void> loadTimers() async {
    final timers = await db.timersList();
    resentNotifier.setTimers(timers);
  }

  TimerBloc getBloc (TimerModel timer) {
    return blocManager.blocsMap[timer.id]!;
  }

  void removeActiveTimer(TimerModel timer) {
    activeNotifier.removeTimer(timer);
  }

}