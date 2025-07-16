import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/padding_wrapper.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/slidable_timer_list_tile/widget/timer_list_tile/timer_list_tile.dart';

class SlidableTimerListTile extends StatelessWidget {
  const SlidableTimerListTile({
    super.key,
    required this.type,
    required this.timer,
  });
  final TimerType type;
  final TimerModel timer;

  @override
  Widget build(BuildContext context) {
    final timerManager = context.read<TimerManager>();
    return Slidable(
        key: ValueKey(timer.id),
        endActionPane: ActionPane(
            extentRatio: 0.13,
            dismissible: DismissiblePane(
                onDismissed: (type == TimerType.active)
                    ? () {
                        timerManager.removeActiveTimer(timer);
                      }
                    : () {
                        timerManager.removeRecentTimer(timer);
                      }),
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                padding: EdgeInsets.zero,
                onPressed: (type == TimerType.active)
                    ? (context) {
                        timerManager.removeActiveTimer(timer);
                      }
                    : (contex) {
                        timerManager.removeRecentTimer(timer);
                      },
                label: "Удалить",
                backgroundColor: CupertinoColors.systemRed,
              ),
            ]),
        child: Column(
          children: [
            Divider(
              indent: 10,
              height: 0,
              color: const Color.fromARGB(255, 21, 21, 21),
              thickness: 0.5,
            ),
            PaddingWrapper(
              child: TimerListTile(
                  timer: timer,
                  type: (type == TimerType.active)
                      ? TimerType.active
                      : TimerType.recent),
            ),
          ],
        ));
  }
}






