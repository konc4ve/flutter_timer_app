import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/common/common.dart';
import 'package:flutter_timer_app/feature/active_timer_overview/view/active_timer_overview_tile.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';

class ActiveTimersOverviewList extends StatelessWidget {
  const ActiveTimersOverviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActiveTimersOverviewBloc(
        context.read<ActiveTimersOverviewRepository>(),
      )..add(ActiveTimersOverviewSubscriptionRequested()),
      child: ActiveTimersOverviewListView(),
    );
  }
}

class ActiveTimersOverviewListView extends StatefulWidget {
  const ActiveTimersOverviewListView({super.key});

  @override
  State<ActiveTimersOverviewListView> createState() =>
      _ActiveTimersOverviewListViewState();
}

class _ActiveTimersOverviewListViewState
    extends State<ActiveTimersOverviewListView> {



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTimersOverviewBloc, ActiveTimersOverviewState>(
      builder: (context, state) {
        if (state.status == ActiveTimersOverviewStatus.loading) {
          return SliverFillRemaining(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final timer = state.activeTimers[index];

            return SlidableWrapper(
              onPressed: (context) => context.read<ActiveTimersOverviewBloc>().add(
                ActiveTimersOverviewTimerDeleted(timer: timer),
              ),
              onDismissed: () => context.read<ActiveTimersOverviewBloc>().add(
                ActiveTimersOverviewTimerDeleted(timer: timer),
              ),
              widget: ActiveTimerOverviewTile(timer: timer),
              valueKey: ValueKey(timer.id),
            );
          }, childCount: state.activeTimers.length),
        );
      },
    );
  }
}
