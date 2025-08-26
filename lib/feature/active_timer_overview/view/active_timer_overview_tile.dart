import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_timer_app/feature/active_timers_overview/models/models.dart';
import 'package:flutter_timer_app/feature/active_timer_overview/bloc/active_timer_overview_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ActiveTimerOverviewTile extends StatelessWidget {
  const ActiveTimerOverviewTile({required this.timer, super.key});

  final ActiveTimer timer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActiveTimerOverviewBloc(
        initDuration: timer.remainingDuration,
        stopWatchTimer: StopWatchTimer(
          mode: StopWatchMode.countDown,
          presetMillisecond: timer.remainingDuration.inMilliseconds,
        ),
      )..add(ActiveTimerStarted()),
      child: TimerOverviewTileView(timer: timer),
    );
  }
}

class TimerOverviewTileView extends StatefulWidget {
  const TimerOverviewTileView({required this.timer, super.key});

  final ActiveTimer timer;

  @override
  State<TimerOverviewTileView> createState() => _TimerOverviewTileViewState();
}

class _TimerOverviewTileViewState extends State<TimerOverviewTileView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTimerOverviewBloc, ActiveTimerOverviewState>(
      builder: (context, state) {
        if (state is! ActiveTimerOverviewRunComplete) {
          return CupertinoListTile(
            title: Text(state.duration.inSeconds.toString()),
            trailing: (state is ActiveTimerOverviewRunInProgress)
                ? IconButton(
                    onPressed: () => context
                        .read<ActiveTimerOverviewBloc>()
                        .add(ActiveTimerPaused()),
                    icon: Icon(CupertinoIcons.pause),
                  )
                : IconButton(
                    onPressed: () => context
                        .read<ActiveTimerOverviewBloc>()
                        .add(ActiveTimerStarted()),
                    icon: Icon(CupertinoIcons.play_arrow_solid),
                  ),
          );
        }
        return SizedBox();
      },
    );
  }
}
