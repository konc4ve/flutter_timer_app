import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/timer_editor_model.dart';
import 'package:provider/provider.dart';


class TimerControlButtons extends StatefulWidget {
  final bool isCancelBtnEnable;
  const TimerControlButtons({required this.isCancelBtnEnable,super.key});

  @override
  State<TimerControlButtons> createState() => _TimerControlButtonsState();
}

class _TimerControlButtonsState extends State<TimerControlButtons> {
  @override
  Widget build(BuildContext context) {
  final TimerEditorModel timerEditorModel = context.watch<TimerEditorModel>();
  final isStartEnable = timerEditorModel.duration > 0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              height: 70,
              child: FloatingActionButton(
                
                heroTag: 'cancelBtn',
                onPressed: (widget.isCancelBtnEnable) ? () {} : null,
                shape: const CircleBorder(),
                child: const Text("Отмена", textAlign: TextAlign.center),
              ),
            ),
            SizedBox(
              width: 100,
              height: 70,
              child: FloatingActionButton(
                heroTag: 'startBtn',
                onPressed: (isStartEnable) ? () {
                  final timer = timerEditorModel.getEditedTimer();
                  context.read<TimerManager>().createAndRunTimer(timer: timer, saveToDb: true);
                  timerEditorModel.labelTextController.clear();
                } : null,
                backgroundColor: Colors.green,
                shape: const CircleBorder(),
                child: const Text("Старт", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}