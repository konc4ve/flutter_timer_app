import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/common/utils/formated_duration.dart';
import 'package:flutter_timer_app/timers/common/widgets/timer_list_tile.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/timers/feature/recent_timer_overview/cubit/recent_timer_overview_cubit.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/models/recent_timer_entity.dart';

import 'package:flutter_timer_app/theme/theme.dart';
import 'package:get_it/get_it.dart';

class RecentTimerOverviewTile extends StatelessWidget {
  const RecentTimerOverviewTile({
    this.onAction,
    required this.timer,
    super.key,
  });

  final VoidCallback? onAction;
  final RecentTimerEntity timer;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentTimerOverviewCubit(
        recentTimerEntity: timer,
        activeTimersOverviewRepository: GetIt.I<ActiveTimersOverviewRepository>(),
      ),
      child: RecentTimerOverviewTileView(timer: timer, onAction: onAction),
    );
  }
}

class RecentTimerOverviewTileView extends StatelessWidget {
  const RecentTimerOverviewTileView({
    this.onAction,
    required this.timer,
    super.key,
  });
  final RecentTimerEntity timer;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return TimerListTile(
      label: timer.label,
      duration: timer.setDuration,
      title: Text(
        RecentTimerFormatedDuration().format(timer.setDuration),
        style: theme.textTheme.dateTimePickerTextStyle,
      ),
      trailing: GestureDetector(
        onTap: () {
          context.read<RecentTimerOverviewCubit>().runActiveTimerFromRecent(
            timer.id,
          );
          if (onAction != null) {
            onAction!();
          }
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(27.5),
            color: TimersTheme.actionButtonsBackgroundColor,
          ),
          child: Transform.translate(
            offset: Offset(1, 0),
            child: Icon(
              CupertinoIcons.play_arrow_solid,
              color: CupertinoColors.systemGreen,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
