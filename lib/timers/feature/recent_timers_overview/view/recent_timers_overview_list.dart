import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/common/common.dart';
import 'package:flutter_timer_app/timers/feature/recent_timer_overview/view/view.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/bloc/recent_timers_overview_bloc.dart';
import 'package:flutter_timer_app/theme/theme.dart';
import 'package:sliver_tools/sliver_tools.dart';

class RecentTimersOverviewList extends StatelessWidget {
  const RecentTimersOverviewList({this.onAction, super.key});

  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return BlocBuilder<RecentTimersOverviewBloc, RecentTimersOverviewState>(
      builder: (context, state) {
        if (state.status == RecentTimersOverviewStatus.loading) {
          return SliverFillRemaining(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        return MultiSliver(
          children: [
            state.timers.isNotEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Недавние',
                        style: theme.textTheme.actionSmallTextStyle,
                      ),
                    ),
                  )
                : SizedBox(),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final timer = state.timers[index];
                return SlidableWrapper(
                  key: ValueKey(timer.id),
                  onPressed: (context) {
                    context.read<RecentTimersOverviewBloc>().add(
                      RecentTimersOverviewTimerDeleted(timer),
                    );
                  },
                  onDismissed: () => context
                      .read<RecentTimersOverviewBloc>()
                      .add(RecentTimersOverviewTimerDeleted(timer)),
                  valueKey: ValueKey(timer.id),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        (index == 0) ? TimersTheme.tileDivider : SizedBox(),
                        RecentTimerOverviewTile(
                          onAction: onAction,
                          timer: timer,
                        ),
                        TimersTheme.tileDivider,
                      ],
                    ),
                  ),
                );
              }, childCount: state.timers.length),
            ),
          ],
        );
      },
    );
  }
}
