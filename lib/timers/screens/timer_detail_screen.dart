
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/common/utils/formated_duration.dart';
import 'package:flutter_timer_app/timers/common/utils/formated_label.dart';
import 'package:flutter_timer_app/timers/common/show_timer_completed_dialog.dart';
import 'package:flutter_timer_app/timers/common/widgets/active_timer_buttons.dart';
import 'package:flutter_timer_app/timers/services/alarm_player.dart';
import 'package:flutter_timer_app/timers/feature/active_timer_overview/timer_overview.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/edit_timer.dart';
import 'package:intl/intl.dart';

import '../common/widgets/timer_edit_panel/timer_edit_panel.dart';

class TimerDetailScreen extends StatefulWidget {
  const TimerDetailScreen({
    required AlarmPlayer player,
    required AnimationController controller,
    required ActiveTimerEntity timer,
    super.key,
  }) : _timer = timer,
       _animationController = controller,
       _alarmPlayer = player;

  final ActiveTimerEntity _timer;
  final AlarmPlayer _alarmPlayer;
  final AnimationController _animationController;

  @override
  State<TimerDetailScreen> createState() => _TimerDetailScreenState();
}

class _TimerDetailScreenState extends State<TimerDetailScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _textEditingController;
  late final AnimationController _animationController;

  late final EditTimerBloc _editTimerBloc;
  @override
  void initState() {
    super.initState();
    _editTimerBloc = context.read<EditTimerBloc>()
      ..add(EditTimerMelodyChanged(widget._timer.alarmMelody));
    _textEditingController = TextEditingController(text: widget._timer.label);
    _textEditingController.addListener(() {
      _editTimerBloc.add(EditTimerLabelChanged(_textEditingController.text));
    });
    _animationController = AnimationController(
      vsync: this,
      duration: widget._animationController.duration,
      value: widget._animationController.value,
    );
    if (widget._animationController.isAnimating) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ActiveTimerOverviewBloc, ActiveTimerOverviewState>(
          listener: (context, state) async {
            if (state is ActiveTimerOverviewRunComplete) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (rotes) => false);
              showTimerCompletedDialog(
                context,
                widget._timer,
                widget._alarmPlayer,
              );
              await widget._alarmPlayer.play(
                _editTimerBloc.state.melody.filename,
              );
            }
          },
        ),
      ],
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyMiddle: true,
          padding: EdgeInsetsDirectional.zero,
          middle: Text(formatLabelFromDuration(widget._timer.remainDuration)),
          leading: GestureDetector(
            onTap: () {
              _editTimerBloc.add(EditTimerSubmitted());
              widget._animationController.value = _animationController.value;
              if (_animationController.isAnimating) {
                widget._animationController.forward();
              }
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.back),
                Text(
                  'Таймеры',
                  style: TextStyle(color: CupertinoColors.systemOrange),
                ),
              ],
            ),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  width: 500,
                  height: 330,
                  child: Stack(
                    alignment: AlignmentGeometry.topCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Positioned(
                            top: 80,
                            child:
                                BlocBuilder<
                                  ActiveTimerOverviewBloc,
                                  ActiveTimerOverviewState
                                >(
                                  builder: (context, state) {
                                    final endTime = DateTime.now().add(
                                      state.duration,
                                    );
                                    final formatedTime = DateFormat.Hm().format(
                                      endTime,
                                    );
                                    final currentState = state;
                                    return Row(
                                      spacing: 5,

                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.bell_fill,
                                          color:
                                              (currentState
                                                  is ActiveTimerOverviewRunInProgress)
                                              ? const Color.fromARGB(
                                                  255,
                                                  124,
                                                  124,
                                                  124,
                                                )
                                              : const Color.fromARGB(
                                                  255,
                                                  44,
                                                  44,
                                                  44,
                                                ),
                                          size: 20,
                                        ),
                                        Text(
                                          formatedTime,
                                          style: TextStyle(
                                            color:
                                                (currentState
                                                    is ActiveTimerOverviewRunInProgress)
                                                ? const Color.fromARGB(
                                                    255,
                                                    124,
                                                    124,
                                                    124,
                                                  )
                                                : const Color.fromARGB(
                                                    255,
                                                    44,
                                                    44,
                                                    44,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          ),
                          BlocBuilder<
                            ActiveTimerOverviewBloc,
                            ActiveTimerOverviewState
                          >(
                            builder: (context, state) {
                              return Text(
                                ActiveTimerFormatedDuration().format(
                                  state.duration,
                                ),
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w100,
                                ),
                              );
                            },
                          ),
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return SizedBox(
                                height: 300,
                                width: 300,
                                child: CircularProgressIndicator(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    22,
                                    22,
                                    22,
                                  ),
                                  strokeCap: StrokeCap.round,
                                  strokeWidth: 6,
                                  value: 1 - _animationController.value,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child:
                            BlocBuilder<
                              ActiveTimerOverviewBloc,
                              ActiveTimerOverviewState
                            >(
                              builder: (context, state) {
                                return ActiveTimerButtons(
                                  onCancel: () {
                                    Navigator.pop(context);
                                    context
                                        .read<ActiveTimersOverviewBloc>()
                                        .add(
                                          ActiveTimersOverviewTimerDeleted(
                                            timer: widget._timer,
                                          ),
                                        );
                                  },
                                  onTogglePause: () {
                                    if (state is ActiveTimerOverviewRunPause) {
                                      context
                                          .read<ActiveTimerOverviewBloc>()
                                          .add(ActiveTimerStarted());
                                      _animationController.forward();
                                    } else {
                                      context
                                          .read<ActiveTimerOverviewBloc>()
                                          .add(ActiveTimerPaused());
                                      _animationController.stop();
                                    }
                                  },
                                  isPaused:
                                      state is ActiveTimerOverviewRunPause,
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                TimerEditPanel(
                  editTimerBloc: _editTimerBloc,
                  controller: _textEditingController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
