import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';


class TimersListNotifier extends ChangeNotifier {

  final List<TimerModel> _timersList = [];



  List<TimerModel> get timersList => _timersList;
  Future<void> addTimer (TimerModel timer) async {
    _timersList.add(timer);
    notifyListeners();
  }

  Future<void> removeTimer(TimerModel timer) async {
    try {
      _timersList.removeWhere((t) => t.id == timer.id);
      notifyListeners();
    } catch (e) {
      debugPrint('Ошибка при удалении таймера: $e');
      rethrow;
    }
  }

  void setTimers(List<TimerModel> timers) {
    _timersList
      ..clear()
      ..addAll(timers);
    notifyListeners(); 
  }

}