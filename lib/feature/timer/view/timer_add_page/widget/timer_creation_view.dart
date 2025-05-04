import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/widget/timer_configuration_panel.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/widget/timer_wheel_picker.dart';

class TimerCreationView extends StatelessWidget {
  final void Function(int hours, int minutes, int seconds) onTimeChanged;
  const TimerCreationView({super.key, required this.onTimeChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        TimerWheelPicker(onChanged: onTimeChanged,),
        TimerConfigurationPanel(),
      ],
    );
  }
}