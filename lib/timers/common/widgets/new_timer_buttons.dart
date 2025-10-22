import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/bloc/edit_timer_bloc.dart';
import 'package:flutter_timer_app/theme/theme.dart';

/// Кнопки на главном экране — запуск нового таймера
class NewTimerButtons extends StatelessWidget {
  const NewTimerButtons({required this.onStartPressed, super.key});

  final VoidCallback onStartPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Отмена всегда disabled
        CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(35),
          onPressed: null,
          color: const Color.fromARGB(255, 37, 9, 6),
          disabledColor: const Color.fromRGBO(18, 6, 6, 1),
          child: const SizedBox(
            width: 70,
            height: 70,
            child: Center(
              child: Text(
                'Отмена',
                style: TextStyle(
                  fontSize: 15,
                  color: CupertinoColors.systemRed,
                ),
              ),
            ),
          ),
        ),

        // Старт — активен только если duration > 0
        BlocBuilder<EditTimerBloc, EditTimerState>(
          builder: (context, state) => CupertinoButton(
            borderRadius: BorderRadius.circular(35),
            padding: EdgeInsets.zero,
            color: TimersTheme.actionButtonsBackgroundColor,
            onPressed: (state.duration != Duration.zero)
                ? onStartPressed
                : null,
            disabledColor: const Color.fromARGB(255, 4, 7, 3),
            child: const SizedBox(
              width: 70,
              height: 70,
              child: Center(
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
        ),
      ],
    );
  }
}
