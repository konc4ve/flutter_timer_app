import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:uuid/uuid.dart';

class TimerActiveListNotifier extends ChangeNotifier {
  final List<TimerModel> _timersActiveList = [];

  List<TimerModel> get activeTimers => _timersActiveList;

  TimerModel createFromTemplate (TimerModel template) {
    final uuid = Uuid();
    final activeTimer = template.copyWith(id: uuid.v4());
    _timersActiveList.add(activeTimer);
    notifyListeners();
    return activeTimer;
  }

  void removeTimer(TimerModel timer) {
    _timersActiveList.removeWhere((element) => element.id == timer.id);
    notifyListeners();
  }

}