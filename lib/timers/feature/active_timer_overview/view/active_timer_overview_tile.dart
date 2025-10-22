
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/common/utils/formated_duration.dart';
import 'package:flutter_timer_app/timers/common/show_timer_completed_dialog.dart';
import 'package:flutter_timer_app/timers/common/widgets/timer_list_tile.dart';
import 'package:flutter_timer_app/timers/services/alarm_player.dart';

import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/timers/feature/active_timer_overview/bloc/active_timer_overview_bloc.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/bloc/edit_timer_bloc.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/models/edit_timer.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/data/recent_timers_overview_repository.dart';
import 'package:flutter_timer_app/timers/screens/timer_detail_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ActiveTimerOverviewTile extends StatefulWidget {
  const ActiveTimerOverviewTile({required this.timer, super.key});

  final ActiveTimerEntity timer;

  @override
  State<ActiveTimerOverviewTile> createState() =>
      _ActiveTimerOverviewTileState();
}

class _ActiveTimerOverviewTileState extends State<ActiveTimerOverviewTile> {
  late final AlarmPlayer _player;

  @override
  void initState() {
    _player = GetIt.I<AlarmPlayer>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActiveTimerOverviewBloc(
        timer: widget.timer,
        stopWatchTimer: StopWatchTimer(
          mode: StopWatchMode.countDown,
          presetMillisecond: Duration(
            seconds: widget.timer.remainDuration.inSeconds + 1,
          ).inMilliseconds,
        ),
        activeTimersOverviewRepository: GetIt.I<ActiveTimersOverviewRepository>(),
      ),

      child: BlocListener<ActiveTimerOverviewBloc, ActiveTimerOverviewState>(
        listener: (context, state) async {
          if (state is ActiveTimerOverviewRunComplete) {
            showTimerCompletedDialog(context, widget.timer, _player);
            await _player.play(widget.timer.alarmMelody.filename);
          }
        },
        child: TimerOverviewTileView(player: _player, timer: widget.timer),
      ),
    );
  }
}

class TimerOverviewTileView extends StatefulWidget {
  const TimerOverviewTileView({
    required AlarmPlayer player,
    required this.timer,
    super.key,
  }) : _player = player;

  final ActiveTimerEntity timer;
  final AlarmPlayer _player;
  @override
  State<TimerOverviewTileView> createState() => _TimerOverviewTileViewState();
}

class _TimerOverviewTileViewState extends State<TimerOverviewTileView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.timer.setDuration,
    );
    controller.forward();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    activeTimersOverviewRepository: GetIt.I<ActiveTimersOverviewRepository>(),
                    recentTimersOverviewRepository: GetIt.I<RecentTimersOverviewRepository>(),
                    initialTimer: EditTimer.fromActive(widget.timer),
                  ),
                ),
              ],
              child: TimerDetailScreen(
                player: widget._player,
                controller: controller,
                timer: widget.timer,
              ),
            ),
          ),
        );
      },
      label: widget.timer.label,
      duration: widget.timer.remainDuration,
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
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      color: const Color.fromARGB(255, 23, 23, 23),
                      value: 1,
                      strokeWidth: 3,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return SizedBox.expand(
                        child: CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          strokeWidth: 3,
                          value: 1.0 - controller.value,
                        ),
                      );
                    },
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
