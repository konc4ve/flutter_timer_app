import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_editor_model.dart';
import 'package:flutter_timer_app/feature/timer/view/common_widgets/timer_configuration_panel/timer_configuration_panel.dart';
import 'package:flutter_timer_app/feature/timer/view/common_widgets/timer_wheel_picker.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TimerAddSheetContent extends StatelessWidget {
  const TimerAddSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final timerManager = context.read<TimerManager>();
    final TimerEditorModel timerEditorModel = context.watch<TimerEditorModel>();
    final isButtonEnabled = timerEditorModel.duration > Duration.zero;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Таймер',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.amber,
            )),
        actions: [
          TextButton(
              onPressed: isButtonEnabled
                  ? () {
                      final timer = timerEditorModel.getEditedTimer();
                      final saveToDb = timerManager.isNew(timer);
                      context
                          .read<TimerManager>()
                          .createAndRunTimer(timer: timer, saveToDb: saveToDb);
                      Navigator.pop(context);
                    }
                  : null,
              child: Text('Запустить')),
        ],
      ),
      body: Column(
        children: [
          TimerWheelPicker(
            onTimerDurationChanged: (seconds) =>
                timerEditorModel.updateDuration(seconds),
          ),
          TimerConfigurationPanel(
            controller: timerEditorModel.labelTextController,
          ),
        ],
      ),
    );
  }
}

void openTimerAddSheet(BuildContext context) {
  showCupertinoModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const TimerAddSheetContent(),
  );
}
