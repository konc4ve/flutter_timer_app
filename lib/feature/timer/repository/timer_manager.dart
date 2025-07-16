import 'package:flutter_timer_app/feature/timer/state/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/state/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_editor_model.dart';
import 'package:flutter_timer_app/feature/timer/state/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/state/timers_bloc_manager.dart';

enum TimerType {
  recent,
  active
}

class TimerManager {
  TimerRecentListNotifier recentNotifier;
  TimerActiveListNotifier activeNotifier;
  TimerDatabase db;
  TimersBlocManager blocManager;
  TimerEditorModel timerEditorModel;
  TimerManager({required this.timerEditorModel, required this.activeNotifier, required this.recentNotifier, required this.db, required this.blocManager});


Future<void> createAndRunTimer({required TimerModel timer, required bool saveToDb}) async {
  if (saveToDb) {
    await db.insertTimer(timer);
    recentNotifier.addTimer(timer);
  }
  final activeTimer = activeNotifier.createFromTemplate(timer);
  final bloc = blocManager.getBloc(activeTimer);
  bloc.add(TimerStarted(duration: timer.duration));
  timerEditorModel.updateDuration(Duration.zero);
}
  

  Future<void> removeRecentTimer(TimerModel timer) async {
    await db.deleteTimer(timer);
    recentNotifier.removeTimer(timer);
  }

  Future<void> loadTimers() async {
    final timers = await db.timersList();
    recentNotifier.setTimers(timers);
  }

  TimerBloc? getBloc (TimerModel timer) {
    return blocManager.blocsMap[timer.id];
  }

  void removeActiveTimer(TimerModel timer) {
    activeNotifier.removeTimer(timer);
  }

String formatedLabel(TimerModel timer) {
  final duration = timer.duration;
  final hour = duration.inHours;
  final min = duration.inMinutes.remainder(60);
  final sec = duration.inSeconds.remainder(60);

  List<String> parts = [];

  if (hour > 0) parts.add('$hour ч');
  if (min > 0) parts.add('$min мин');
  if (sec > 0) parts.add('$sec с');

  return parts.join(', ');
}

bool isNew(TimerModel timer) {
  return !recentNotifier.timersList.any((t) => t.duration == timer.duration);
}

String formatedDuration(Duration duration,{required TimerType type}) {
  final hour = duration.inHours;
  final min = duration.inMinutes.remainder(60);
  final sec =  duration.inSeconds.remainder(60);

  String toDigits(n) => n.toString().padLeft(2,'0');
  
  if (type == TimerType.active) {
    if (hour > 0) {
      return 
      '${toDigits(hour)}:'
      '${toDigits(min)}:'
      '${toDigits(sec)}';
    }
    else {
      return 
      '${toDigits(min)}:'
      '${toDigits(sec)}';
    }
  }
  if (type == TimerType.recent) {
    if (hour > 0) {
      return
      '${hour.toString()}:'
      '${toDigits(min)}:'
      '${toDigits(sec)}';
    }
    if (min > 0) {
      return
      '${min.toString()}:'
      '${toDigits(sec)}';
    }
    if (sec > 0) {
      return sec.toString();
      
    }
  }
  return 'Ошибка';
}

}