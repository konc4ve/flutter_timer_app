import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/edit_timer/bloc/edit_timer_bloc.dart';
import 'package:flutter_timer_app/theme/theme.dart';

class TimerControlButtons extends StatelessWidget {
  const TimerControlButtons({required this.onPressed, super.key});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(35),
          onPressed: null,
          color: const Color.fromARGB(255, 37, 9, 6),
          disabledColor: Color.fromRGBO(18, 6, 6, 1),
          child: Container(
            alignment: Alignment.center,
            width: 70,
            height: 70,
            child: Text(
              'Отмена',
              style: TextStyle(fontSize: 15, color: CupertinoColors.systemRed),
            ),
          ),
        ),
        BlocBuilder<EditTimerBloc, EditTimerState>(
          builder: (context, state) => CupertinoButton(
            borderRadius: BorderRadius.circular(35),
            padding: EdgeInsets.zero,
            color: TimersTheme.actionButtonsBackgroundColor,
            onPressed: (state.duration != Duration.zero) ? onPressed : null,
            disabledColor: Color.fromARGB(255, 4, 7, 3),
            child: Container(
              alignment: Alignment.center,
              width: 70,
              height: 70,
              child: Text(
                'Старт',
                style: TextStyle(
                  fontSize: 15,
                  color: CupertinoColors.systemGreen,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
