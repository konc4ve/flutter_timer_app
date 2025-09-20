import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/common/common.dart';
import 'package:flutter_timer_app/feature/active_timer_overview/view/active_timer_overview_tile.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/service/active_timer_bloc_manager.dart';
import 'package:flutter_timer_app/theme/theme.dart';
import 'package:provider/provider.dart';

class ActiveTimersOverviewList extends StatelessWidget {
  const ActiveTimersOverviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ActiveTimersBlocManager(
        repository: context.read<ActiveTimersOverviewRepository>(),
      ),
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
    extends State<ActiveTimersOverviewListView>
    with TickerProviderStateMixin {
  final Map<String, AnimationController> _controllers = {};

  AnimationController _getControllerForTimer(ActiveTimer timer) {
    return _controllers.putIfAbsent(
      timer.id,
      () => AnimationController(
        vsync: this,
        duration: timer.duration - Duration(seconds: 1),
      ),
    );
  }


  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTimersOverviewBloc, ActiveTimersOverviewState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final timer = state.activeTimers[index];
            return SlidableWrapper(
              onPressed: (context) {
                context.read<ActiveTimersOverviewBloc>().add(
                  ActiveTimersOverviewTimerDeleted(timer: timer),
                );
                context.read<ActiveTimersBlocManager>().dispose(timer.id);
              },
              onDismissed: () => context.read<ActiveTimersOverviewBloc>().add(
                ActiveTimersOverviewTimerDeleted(timer: timer),
              ),
              widget: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    (index == 0) ? TimersTheme.tileDivider : SizedBox(),
                    BlocProvider.value(
                      value: context
                          .read<ActiveTimersBlocManager>()
                          .getBlocForTimer(timer),
                      child: ActiveTimerOverviewTile(
                        key: ValueKey(timer.id),
                        timer: timer,
                        controller: _getControllerForTimer(timer),
                      ),
                    ),
                    TimersTheme.tileDivider,
                  ],
                ),
              ),
              valueKey: ValueKey(timer.id),
            );
          }, childCount: state.activeTimers.length),
        );
      },
    );
  }
}
