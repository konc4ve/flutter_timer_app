import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/timers_list_notifier.dart';
import 'package:flutter_timer_app/feature/timers_bloc_manager.dart';

class TimerPresentRepository {
  TimersListNotifier notifier;
  TimerDatabase db;
  TimersBlocManager blocManager;
  TimerPresentRepository({required this.notifier, required this.db, required this.blocManager});

  Future<void> addTimer(TimerModel timer) async {
    await db.insertTimer(timer);
    notifier.addTimer(timer);
    blocManager.getBloc(timer);
  }

  Future<void> removeTimer(TimerModel timer) async {
    await db.deleteTimer(timer);
    notifier.removeTimer(timer);
    blocManager.removeBloc(timer);
  }
  
  Future<void> loadTimers() async {
    final timers = await db.timersList();
    notifier.setTimers(timers);
    for (TimerModel timer in timers) {
      blocManager.getBloc(timer);
    }
  }

  void runTimer(TimerModel timer) {
  final bloc = blocManager.blocsMap[timer.id];
  if (bloc == null) {
    print('Bloc for timer ${timer.id} not found');
  } else {
    print('Starting timer ${timer.id} with duration ${timer.duration}');
    bloc.add(TimerStarted(duration: timer.duration));
  }
}
  TimerBloc getBloc (TimerModel timer) {
    return blocManager.blocsMap[timer.id]!;
  }
}