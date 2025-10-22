import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_app/timers/common/utils/formated_label.dart';
import 'package:flutter_timer_app/timers/services/alarm_player.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';

void showTimerCompletedDialog(
  context,
  ActiveTimerEntity timer,
  AlarmPlayer player,
) {
  showCupertinoDialog(
    useRootNavigator: false,
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: (timer.label == '')
          ? Text(
              'Таймер ${formatLabelFromDuration(timer.setDuration)} завершен',
            )
          : Text('Таймер ${timer.label} завершен'),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await player.stop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}
