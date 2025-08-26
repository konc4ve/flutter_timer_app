import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/recent_timer_overview/cubit/recent_timer_overview_cubit.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';

class RecentTimerOverviewTile extends StatelessWidget {
  const RecentTimerOverviewTile({required this.timer, super.key});
  final RecentTimer timer;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentTimerOverviewCubit(
        recentTimersOverviewRepository: context.read<RecentTimersOverviewRepository>(),
        activeTimersOverviewRepository: context.read<ActiveTimersOverviewRepository>()
      ),
      child: RecentTimerOverviewTileView(timer: timer),
    );
  }
}

class RecentTimerOverviewTileView extends StatefulWidget {
  const RecentTimerOverviewTileView({required this.timer, super.key});
  final RecentTimer timer;
  @override
  State<RecentTimerOverviewTileView> createState() =>
      _RecentTimerOverviewTileViewState();
}

class _RecentTimerOverviewTileViewState
    extends State<RecentTimerOverviewTileView> {


  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(widget.timer.duration.toString()),
      trailing: IconButton(
        onPressed: () =>
            context.read<RecentTimerOverviewCubit>().runActiveTimerFromRecent(widget.timer.id),
        icon: Icon(CupertinoIcons.play_arrow),
      ),
    );
  }
}
