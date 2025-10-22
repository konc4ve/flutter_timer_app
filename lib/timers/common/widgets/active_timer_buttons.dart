import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_app/theme/theme.dart';

/// Кнопки на экране детального просмотра активного таймера
class ActiveTimerButtons extends StatelessWidget {
  const ActiveTimerButtons({
    required this.onCancel,
    required this.onTogglePause,
    required this.isPaused,
    super.key,
  });

  final VoidCallback onCancel;
  final VoidCallback onTogglePause;
  final bool isPaused;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Удаление таймера
        CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(35),
          onPressed: onCancel,
          color: const Color.fromARGB(255, 37, 9, 6),
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

        // Пауза / Продолжить
        CupertinoButton(
          borderRadius: BorderRadius.circular(35),
          padding: EdgeInsets.zero,
          color: isPaused
              ? TimersTheme.actionButtonsBackgroundColor
              : const Color.fromARGB(255, 65, 39, 0),
          onPressed: onTogglePause,
          child: SizedBox(
            width: 70,
            height: 70,
            child: Center(
              child: Text(
                isPaused ? 'Старт' : 'Пауза',
                style: TextStyle(
                  fontSize: 15,
                  color: isPaused
                      ? CupertinoColors.systemGreen
                      : CupertinoColors.systemOrange,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
