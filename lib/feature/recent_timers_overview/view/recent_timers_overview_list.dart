import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/common/common.dart';
import 'package:flutter_timer_app/feature/recent_timer_overview/view/view.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/bloc/recent_timers_overview_bloc.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/data/recent_timers_overview_repository.dart';

class RecentTimersOverviewList extends StatelessWidget {
  const RecentTimersOverviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentTimersOverviewBloc(
        resentTimersRepository: context.read<RecentTimersOverviewRepository>(),
      )..add(RecentTimersOverviewSubscriptionRequested()),
      child: RecentTimersOveviewListView(),
    );
  }
}

class RecentTimersOveviewListView extends StatefulWidget {
  const RecentTimersOveviewListView({super.key});

  @override
  State<RecentTimersOveviewListView> createState() =>
      _RecentTimersOveviewListViewState();
}

class _RecentTimersOveviewListViewState
    extends State<RecentTimersOveviewListView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentTimersOverviewBloc, RecentTimersOverviewState>(
      builder: (context, state) {
        if (state.status == RecentTimersOverviewStatus.loading) {
          return SliverFillRemaining(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final timer = state.recentTimers[index];
            return SlidableWrapper(
              onPressed: (context) => context.read<RecentTimersOverviewBloc>().add(
                RecentTimersOverviewTimerDeleted(timer: timer),
              ),
              onDismissed: () => context.read<RecentTimersOverviewBloc>().add(
                RecentTimersOverviewTimerDeleted(timer: timer),
              ),
              widget: RecentTimerOverviewTile(timer: timer,),
              valueKey: ValueKey(timer.id),
            );
          }, childCount: state.recentTimers.length),
        );
      },
    );
  }
}
