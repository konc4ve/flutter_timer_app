import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/timer_editor_model.dart';
import 'package:flutter_timer_app/feature/timer/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/timer_add_page.dart';
import 'package:flutter_timer_app/feature/timer/view/widget/timer_configuration_panel/timer_configuration_panel.dart';
import 'package:flutter_timer_app/feature/timer/view/widget/timer_control_buttons.dart';
import 'package:flutter_timer_app/feature/timer/view/widget/timer_list_tile.dart';
import 'package:flutter_timer_app/feature/timer/view/widget/timer_wheel_picker.dart';

enum TimerListPageMode {
  timerRunElements,
  timerRunning,
}

class TimerListPage extends StatefulWidget {
  const TimerListPage({super.key});

  @override
  State<TimerListPage> createState() => _TimerListPageState();
}

class _TimerListPageState extends State<TimerListPage> {
  

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

    final runningTimers = timersActiveNotifier.activeTimers.reversed.toList();

    final recentTimers = timersRecentNotifier.timersList.reversed.toList();

    (runningTimers.isEmpty) ? mode = TimerListPageMode.timerRunElements : mode = TimerListPageMode.timerRunning;
    final timerManager = context.read<TimerManager>(); 
    
    return Scaffold(
        appBar: AppBar(
          actions: [
            if (mode == TimerListPageMode.timerRunning)
            ...[
              IconButton(
              onPressed: () {
                openTimerAddSheet(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.amber,
              ),
            ),
            ] 
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Таймеры', style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),),
              if (mode == TimerListPageMode.timerRunElements) ...[
                TimerWheelPicker(onChanged: (int h, int min, int sec) {
                  final duration = h * 3600 + min * 60 + sec;
                  setState(() => timerEditorModel.updateDuration(duration));
                }),
                TimerControlButtons(isCancelBtnEnable: false),
                SizedBox(height: 20,),
                TimerConfigurationPanel(controller: timerEditorModel.labelTextController,),
              ],
              if (mode == TimerListPageMode.timerRunning) ...[
                ListenableBuilder(
                listenable: timersActiveNotifier,
                builder: (context, child) {          
                  if (runningTimers.isNotEmpty) {
                    return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: runningTimers.length,
                    itemBuilder: (context, index) {
                      final timer = runningTimers[index];
                      final bloc = context.read<TimerManager>().blocManager.getBloc(timer);
                      return BlocProvider.value(
                        value: bloc,
                        child: BlocBuilder<TimerBloc, TimerState>(builder: (context, state){
                          if (state is! TimerRunComplete) {
                            return Dismissible(
                              key: ValueKey(timer.id),
                              onDismissed: (direction) => timerManager.removeActiveTimer(timer),
                              child: TimerListTile(timerState: state, timerBloc: bloc, timer: timer,)
                              );
                          }
                          else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              timerManager.removeActiveTimer(timer);
                            });
                            return const SizedBox.shrink();
                          } 
                        }),
                      );
                    },
                  );
                  }  
                  return const SizedBox.shrink();
                },
                ),
              ],
              if (recentTimers.isNotEmpty) ...[
                Text('Недавние',textAlign: TextAlign.left, style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),),
                ListenableBuilder(
                  listenable: timersRecentNotifier,
                  builder: (context, child) {
                    return ListView.builder(
                      itemCount: recentTimers.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final timer = recentTimers[index];
                        return Dismissible(
                          key: ValueKey(timer.id),
                          onDismissed: (direction) => timerManager.removeRecentTimer(timer),
                          child: TimerListTile(timer: timer)
                          );
                    });
                  })
              ],  
            ],
          ),
        ));
  }
}

