import 'package:flutter/cupertino.dart';

class TimerWheelPicker extends StatelessWidget {
  const TimerWheelPicker({required this.onTimerDurationChanged, super.key});

  final ValueChanged<Duration> onTimerDurationChanged;
  
  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(onTimerDurationChanged: onTimerDurationChanged);
  }
}