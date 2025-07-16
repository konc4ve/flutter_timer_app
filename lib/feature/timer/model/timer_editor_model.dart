import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:uuid/uuid.dart';


class TimerEditorModel extends ChangeNotifier {
  Duration _duration = Duration.zero;
  final TextEditingController labelTextController = TextEditingController();

  Duration get duration => _duration;

  String get label => labelTextController.text;

  void updateDuration(Duration newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  void clear() {
    _duration = Duration.zero;
    labelTextController.clear();
    notifyListeners();
  }

  TimerModel getEditedTimer() {
    final uuid = Uuid();
    final label = labelTextController.text.trim();
    return TimerModel(
      id: uuid.v4(),
      duration: _duration,
      label: label,
      createdAt: DateTime.now(),
    );
  }
}