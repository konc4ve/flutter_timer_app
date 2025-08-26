import 'package:flutter/cupertino.dart';
import 'package:flutter_timer_app/theme/theme.dart';

class TimerControlButtons extends StatelessWidget {
  const TimerControlButtons({required this.onPressed, super.key});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    // final theme = CupertinoTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(35),
          onPressed: null,
          color: const Color.fromARGB(255, 37, 9, 6),
          disabledColor: Color.fromARGB(255, 18, 6, 6),
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
        CupertinoButton(
          borderRadius: BorderRadius.circular(35),
          padding: EdgeInsets.zero,
          color: TimersTheme.actionButtonsBackgroundColor,
          onPressed: onPressed,
          disabledColor: Color.fromARGB(255, 0, 0, 0),
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
      ],
    );
  }
}
