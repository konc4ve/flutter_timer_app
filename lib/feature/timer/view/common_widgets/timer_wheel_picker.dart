import 'package:flutter/cupertino.dart';

class TimerWheelPicker extends StatelessWidget {
  final void Function(Duration duration) onTimerDurationChanged;

  const TimerWheelPicker({required this.onTimerDurationChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(
      onTimerDurationChanged: (duration) {
        onTimerDurationChanged(duration);
      },
    );
  }
}
