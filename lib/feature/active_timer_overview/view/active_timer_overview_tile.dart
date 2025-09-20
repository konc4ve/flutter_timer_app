import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/common/formated_duration.dart';
import 'package:flutter_timer_app/common/widgets/timer_list_tile.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/active_timer_overview/bloc/active_timer_overview_bloc.dart';
import 'package:flutter_timer_app/feature/edit_timer/bloc/edit_timer_bloc.dart';
import 'package:flutter_timer_app/feature/edit_timer/models/edit_timer.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/data/data.dart';
import 'package:flutter_timer_app/screens/timer_detail_screen.dart';

class ActiveTimerOverviewTile extends StatelessWidget {
  const ActiveTimerOverviewTile({
    required this.controller,
    required this.timer,
    super.key,
  });

  final AnimationController controller;
  final ActiveTimer timer;

  @override
  Widget build(BuildContext context) {
    return TimerOverviewTileView(controller: controller, timer: timer);
  }
}

class TimerOverviewTileView extends StatelessWidget {
  const TimerOverviewTileView({
    required this.controller,
    required this.timer,
    super.key,
  });

  final AnimationController controller;

  final ActiveTimer timer;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return TimerListTile(
      onTap: () {
        final activeTimerBloc = context.read<ActiveTimerOverviewBloc>();
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: activeTimerBloc),
                BlocProvider(
                  create: (context) => EditTimerBloc(
                    activeTimersOverviewRepository: context
                        .read<ActiveTimersOverviewRepository>(),
                    recentTimersOverviewRepository: context
                        .read<RecentTimersOverviewRepository>(),
                    initialTimer: EditTimer.fromActive(timer),
                  ),
                ),
              ],
              child: TimerDetailScreen(
                animationController: controller,
                timer: timer,
              ),
            ),
          ),
        );
      },
      label: timer.label,
      duration: timer.duration,
      title: BlocBuilder<ActiveTimerOverviewBloc, ActiveTimerOverviewState>(
        builder: (context, state) {
          return Text(
            ActiveTimerFormatedDuration().format(state.duration),
            style: theme.textTheme.dateTimePickerTextStyle,
          );
        },
      ),
      trailing: SizedBox(
        height: 55,
        width: 55,
        child: BlocBuilder<ActiveTimerOverviewBloc, ActiveTimerOverviewState>(
          builder: (context, state) {
            if (state is ActiveTimerOverviewRunInProgress &&
                !controller.isAnimating) {
              controller.forward();
            }
            return GestureDetector(
              onTap: () {
                if (state is ActiveTimerOverviewRunInProgress) {
                  context.read<ActiveTimerOverviewBloc>().add(
                    ActiveTimerPaused(),
                  );
                  controller.stop();
                } else {
                  context.read<ActiveTimerOverviewBloc>().add(
                    ActiveTimerStarted(),
                  );
                  controller.forward();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: 1.0 - controller.value,
                      ),
                    );
                    } 
                  ),
                  Icon(
                    state is ActiveTimerOverviewRunInProgress
                        ? CupertinoIcons.pause_solid
                        : CupertinoIcons.play_arrow_solid,
                    size: 22,
                    color: theme.primaryColor,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
