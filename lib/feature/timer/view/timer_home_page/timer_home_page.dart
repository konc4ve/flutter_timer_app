import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/state/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_editor_model.dart';
import 'package:flutter_timer_app/feature/timer/state/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/padding_wrapper.dart';
import 'package:flutter_timer_app/feature/timer/view/common_widgets/timer_configuration_panel/timer_configuration_panel.dart';
import 'package:flutter_timer_app/feature/timer/view/common_widgets/timer_control_buttons.dart';
import 'package:flutter_timer_app/feature/timer/view/common_widgets/timer_wheel_picker.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/timer_add_page.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/active_timers.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/recent_timers.dart';


enum TimerListPageMode {
  timerRunElements,
  timerRunning,
}

class TimerHomePage extends StatefulWidget {
  const TimerHomePage({super.key});

  @override
  State<TimerHomePage> createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TimerManager>().loadTimers();
  }

  @override
  Widget build(BuildContext context) {
    final TimerEditorModel timerEditorModel = context.watch<TimerEditorModel>();

    TimerListPageMode mode = TimerListPageMode.timerRunElements;

    final timersRecentNotifier = context.watch<TimerRecentListNotifier>();
    final timersActiveNotifier = context.watch<TimerActiveListNotifier>();

    final runningTimers = timersActiveNotifier.activeTimers;

    final recentTimers = timersRecentNotifier.timersList;

    (runningTimers.isEmpty)
        ? mode = TimerListPageMode.timerRunElements
        : mode = TimerListPageMode.timerRunning;
    final timerManager = context.read<TimerManager>();

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Таймеры"),
          automaticallyImplyMiddle: false,
          trailing: (mode == TimerListPageMode.timerRunning)
              ? IconButton(
                  onPressed: () {
                    openTimerAddSheet(context);
                  },
                  icon: Icon(CupertinoIcons.add),
                  color: CupertinoColors.activeOrange,
                )
              : null,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SlidableAutoCloseBehavior(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PaddingWrapper(
                    child: Text(
                      'Таймеры',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (mode == TimerListPageMode.timerRunElements) ...[
                    PaddingWrapper(
                      child: TimerWheelPicker(onTimerDurationChanged: (duration) {
                        timerEditorModel.updateDuration(duration);
                      }),
                    ),
                    PaddingWrapper(child: TimerControlButtons(isCancelBtnEnable: false)),
                    SizedBox(
                      height: 20,
                    ),
                    PaddingWrapper(
                      child: TimerConfigurationPanel(
                        controller: timerEditorModel.labelTextController,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                  if (mode == TimerListPageMode.timerRunning) ...[
                    ActiveTimers(timersActiveNotifier: timersActiveNotifier, runningTimers: runningTimers, timerManager: timerManager),
                    Divider(
                      height: 0,
                      color: const Color.fromARGB(255, 21, 21, 21),
                      thickness: 0.5,
                      indent: 10,
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                  if (recentTimers.isNotEmpty) ...[
                    PaddingWrapper(
                      child: Text(
                        'Недавние',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RecentTimers(timersRecentNotifier: timersRecentNotifier, recentTimers: recentTimers),
                  ],
                ],
              ),
            ),
          ),
        ));
  }
}


