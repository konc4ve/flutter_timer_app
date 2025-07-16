import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_editor_model.dart';
import 'package:provider/provider.dart';

class TimerControlButtons extends StatefulWidget {
  final bool isCancelBtnEnable;
  const TimerControlButtons({required this.isCancelBtnEnable, super.key});

  @override
  State<TimerControlButtons> createState() => _TimerControlButtonsState();
}

class _TimerControlButtonsState extends State<TimerControlButtons> {
  @override
  Widget build(BuildContext context) {
    final timerManager = context.read<TimerManager>();

    final TimerEditorModel timerEditorModel = context.watch<TimerEditorModel>();
    final isStartEnable = timerEditorModel.duration > Duration.zero;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey,
                onPressed: (widget.isCancelBtnEnable) ? () {} : null,
                child: const Text(
                  "Отмена",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(100, 0, 50, 0),
                disabledColor: const Color.fromARGB(100, 0, 3, 0),
                onPressed: (isStartEnable)
                    ? () {
                        final timer = timerEditorModel.getEditedTimer();
                        final saveToDb = timerManager.isNew(timer);
                        context.read<TimerManager>().createAndRunTimer(
                            timer: timer, saveToDb: saveToDb);
                      }
                    : null,
                child: const Text(
                  "Старт",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17, color: CupertinoColors.activeGreen),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
