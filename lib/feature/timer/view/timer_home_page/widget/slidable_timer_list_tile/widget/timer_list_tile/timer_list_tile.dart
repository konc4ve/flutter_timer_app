import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/feature/timer/state/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/slidable_timer_list_tile/widget/timer_list_tile/widget/active_timer_control_button.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/slidable_timer_list_tile/widget/timer_list_tile/widget/recent_timer_run_button.dart';

class TimerListTile extends StatelessWidget {
  final TimerType type;
  final TimerModel timer;
  const TimerListTile({
    super.key,
    required this.type,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    final timerManager = context.read<TimerManager>();

    final timerBloc = timerManager.getBloc(timer);

    final String label = timer.label;

    final slidable = Slidable.of(context);

    return ValueListenableBuilder<double>(
      valueListenable: slidable?.animation ?? ValueNotifier(0.0),
      builder: (context, value, child) {
        final isClosed = value == 0.0;
        return CupertinoListTile(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            // onTap: (type == TimerType.active)
            //     ? () {
            //         () => Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => BlocProvider.value(
            //                       value: timerBloc!,
            //                       // child: TimerRunPage(maxDuration: timerBloc!.initDuration,),
            //                     )));
            //       }
            //     : null,
            title: (type == TimerType.active)
                ? Text(
                    timerManager.formatedDuration(timerBloc!.state.duration,
                        type: TimerType.active),
                    style: TextStyle(
                        fontSize: 60,
                        color: const Color.fromARGB(255, 203, 199, 199),
                        fontWeight: FontWeight.w300))
                : Text(
                    timerManager.formatedDuration(timer.duration,
                        type: TimerType.recent),
                    style: TextStyle(
                        fontSize: 60,
                        color: const Color.fromARGB(255, 102, 102, 102),
                        fontWeight: FontWeight.w300)),
            subtitle: Text(
              (label.isEmpty) ? timerManager.formatedLabel(timer) : label,
            ),
            trailing: AnimatedOpacity(
              opacity: isClosed ? 1.0 : 0.0,
              duration: Duration(milliseconds: 50),
              child: (type == TimerType.active)
                  ? BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                        if (state is TimerRunInProgress) {
                          return ActiveTimerControlButton(
                              animationDuration: timer.duration,
                              controlType: ActiveTimerControlType.pause,
                              onTap: () {
                                timerBloc!.add(TimerPaused());
                              });
                        }
                        if (state is TimerRunPause) {
                          return ActiveTimerControlButton(
                              animationDuration: timer.duration,
                              controlType: ActiveTimerControlType.run,
                              onTap: () {
                                timerBloc!.add(TimerStarted(
                                    duration: timerBloc.state.duration));
                              });
                        }
                        if (state is TimerInitial) {
                          return ActiveTimerControlButton(
                              animationDuration: timer.duration,
                              controlType: ActiveTimerControlType.run,
                              onTap: () {
                                timerBloc!.add(TimerStarted(
                                  duration: timerBloc.initDuration,
                                ));
                              });
                        }
                        return SizedBox.shrink();
                      },
                    )
                  : RecentTimerRunButton(
                      timer: timer,
                      onTap: () {
                        context
                            .read<TimerManager>()
                            .createAndRunTimer(timer: timer, saveToDb: false);
                      },
                    ),
            ));
      },
    );
  }
}
