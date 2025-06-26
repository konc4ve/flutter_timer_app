import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';



class TimerRecentListNotifier extends ChangeNotifier {
  final List<TimerModel> _timersRecentList = [];



  List<TimerModel> get timersList => _timersRecentList;
  
  Future<void> addTimer (TimerModel timer) async {
    _timersRecentList.add(timer);
    notifyListeners();
  }

  Future<void> removeTimer(TimerModel timer) async {
    try {
      _timersRecentList.removeWhere((t) => t.id == timer.id);
      notifyListeners();
    } catch (e) {
      debugPrint('Ошибка при удалении таймера: $e');
      rethrow;
    }
  }

  void setTimers(List<TimerModel> timers) {
    _timersRecentList
      ..clear()
      ..addAll(timers);
    notifyListeners(); 
  }

}
