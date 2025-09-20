import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/common/formated_duration.dart';
import 'package:flutter_timer_app/common/formated_label.dart';
import 'package:flutter_timer_app/feature/active_timer_overview/timer_overview.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/edit_timer/edit_timer.dart';

import '../common/widgets/timer_edit_panel/timer_edit_panel.dart';

class TimerDetailScreen extends StatefulWidget {
  const TimerDetailScreen({
    required AnimationController animationController,
    required ActiveTimer timer,
    super.key,
  }) : _timer = timer,
       _animationController = animationController;

  final ActiveTimer _timer;

  final AnimationController _animationController;

  @override
  State<TimerDetailScreen> createState() => _TimerDetailScreenState();
}

class _TimerDetailScreenState extends State<TimerDetailScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget._timer.label);
    _textEditingController.addListener(() {
      context.read<EditTimerBloc>().add(
        EditTimerLabelChanged(_textEditingController.text),
      );
    });


  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyMiddle: true,
        padding: EdgeInsetsDirectional.zero,
        middle: Text(formatLabelFromDuration(widget._timer.duration)),
        leading: GestureDetector(
          onTap: () {
            context.read<EditTimerBloc>().add(EditTimerSubmitted());
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

      child: SafeArea(
        child: BlocListener<ActiveTimerOverviewBloc, ActiveTimerOverviewState>(
          listener: (context, state) {
            if (state is ActiveTimerOverviewRunComplete) {
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              BlocBuilder<ActiveTimerOverviewBloc, ActiveTimerOverviewState>(
                builder: (context, state) {
                  if (state is ActiveTimerOverviewRunInProgress &&
                      !widget._animationController.isAnimating) {
                    widget._animationController.forward();
                  }
                  return Stack(
                    children: [
                      Text(
                        ActiveTimerFormatedDuration().format(state.duration),
                      ),
                      AnimatedBuilder(
                        animation: widget._animationController,
                        builder: (context, child) {
                          print(widget._animationController);
                          return CircularProgressIndicator(
                            value: 1 - widget._animationController.value,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              TimerEditPanel(controller: _textEditingController),
            ],
          ),
        ),
      ),
    );
  }
}
