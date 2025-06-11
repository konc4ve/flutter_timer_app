import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:get_it/get_it.dart';

class TimersListNotifier extends ChangeNotifier {
  final List<TimerModel> _timersList = [];
  final _db = GetIt.instance.get<TimerDatabase>();
  
  List<TimerModel> get timersList => _timersList;

  Future<void> addTimer (TimerModel timer) async {
    _timersList.add(timer);
    notifyListeners();
    await _db.insertTimer(timer);
  }


  Future<void> removeTimer(TimerModel timer) async {
    try {
      _timersList.removeWhere((t) => t.id == timer.id); // Удаляем из списка
      notifyListeners();
      await _db.deleteTimer(timer);
    } catch (e) {
      debugPrint('Ошибка при удалении таймера: $e');
      rethrow;
    }
  }

  Future<void> loadTimers () async {
    final timers = await _db.timersList();
    timersList.addAll(timers);
    notifyListeners();
  }
}