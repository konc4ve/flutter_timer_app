import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/common/common.dart';
import 'package:flutter_timer_app/timers/feature/active_timer_overview/view/active_timer_overview_tile.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/theme/theme.dart';

class ActiveTimersOverviewList extends StatelessWidget {
  const ActiveTimersOverviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return ActiveTimersOverviewListView();
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
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final timer = state.activeTimers[index];

              return SlidableWrapper(
                key: ValueKey(timer.id),
                valueKey: ValueKey(timer.id),
                onPressed: (context) {
                  context.read<ActiveTimersOverviewBloc>().add(
                    ActiveTimersOverviewTimerDeleted(timer: timer),
                  );
                },
                onDismissed: () {
                  context.read<ActiveTimersOverviewBloc>().add(
                    ActiveTimersOverviewTimerDeleted(timer: timer),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      (index == 0) ? TimersTheme.tileDivider : SizedBox(),
                      ActiveTimerOverviewTile(timer: timer),
                      TimersTheme.tileDivider,
                    ],
                  ),
                ),
              );
            },
            childCount: state.activeTimers.length,

            // Сопоставление ключа с индексом для сохранения состояния при изменении порядка
            findChildIndexCallback: (Key key) {
              final valueKey = key as ValueKey<String>;
              return state.activeTimers.indexWhere(
                (t) => t.id == valueKey.value,
              );
            },
          ),
        );
      },
    );
  }
}
