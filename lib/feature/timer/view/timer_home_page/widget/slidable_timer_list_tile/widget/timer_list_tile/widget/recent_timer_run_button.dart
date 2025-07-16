import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';


class RecentTimerRunButton extends StatelessWidget {
  final void Function() onTap;
  const RecentTimerRunButton({
    super.key,
    required this.onTap,
    required this.timer,
  });

  final TimerModel timer;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: () {
          onTap();
        },
        fillColor: Color.fromARGB(255, 5, 28, 14),
        shape: CircleBorder(),
        constraints: BoxConstraints.tight(Size(60, 60)),
        child: Transform.translate(
          offset: Offset(1, 0),
          child: Icon(
            CupertinoIcons.play_fill,
            color: CupertinoColors.activeGreen,
            size: 24,
          ),
        ),
      );
  }
}