import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/common/common.dart';
import 'package:flutter_timer_app/feature/recent_timer_overview/view/view.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/bloc/recent_timers_overview_bloc.dart';
import 'package:flutter_timer_app/theme/theme.dart';
import 'package:sliver_tools/sliver_tools.dart';

class RecentTimersOverviewListView extends StatelessWidget {
  const RecentTimersOverviewListView({this.onAction, super.key});

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
            state.recentTimers.isNotEmpty
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
                final timer = state.recentTimers[index];
                return SlidableWrapper(
                  onPressed: (context) {
                    context.read<RecentTimersOverviewBloc>().add(
                      RecentTimersOverviewTimerDeleted(timer: timer),
                    );
                  },
                  onDismissed: () => context
                      .read<RecentTimersOverviewBloc>()
                      .add(RecentTimersOverviewTimerDeleted(timer: timer)),
                  widget: Padding(
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
                  valueKey: ValueKey(timer.id),
                );
              }, childCount: state.recentTimers.length),
            ),
          ],
        );
      },
    );
  }
}
