import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:uuid/uuid.dart';


class TimerEditorModel extends ChangeNotifier {
  int _duration = 0;
  final TextEditingController labelTextController = TextEditingController();

  int get duration => _duration;

  String get label => labelTextController.text;

  void updateDuration(int newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  void clear() {
    _duration = 0;
    labelTextController.clear();
    notifyListeners();
  }

  TimerModel getEditedTimer() {
    final uuid = Uuid();
    final label = labelTextController.text.trim();
    return TimerModel(
      id: uuid.v4(),
      duration: _duration,
      label: label.isEmpty ? _duration.toString() : label,
      createdAt: DateTime.now(),
    );
  }
}