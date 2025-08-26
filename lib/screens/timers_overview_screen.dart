import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/common/common.dart';
import 'package:flutter_timer_app/common/widgets/timer_control_buttons.dart';
import 'package:flutter_timer_app/common/widgets/timer_edit_panel.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/edit_timer/edit_timer.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/data/data.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/view/recent_timers_overview_list.dart';


class TimersOverviewScreen extends StatelessWidget {
  const TimersOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditTimerBloc(
            recentTimersOverviewRepository: context.read<RecentTimersOverviewRepository>(),
            activeTimersOverviewRepository: context.read<ActiveTimersOverviewRepository>(),
            initialTimer: null,
          ),
        ),
      ],
      child: TimersOverviewScreenView(),
    );
  }
}

class TimersOverviewScreenView extends StatelessWidget {
  const TimersOverviewScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final textTheme = theme.textTheme;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Таймеры')),
      child: SafeArea(
        child: SlidableAutoCloseBehavior(
          child: CustomScrollView(
            
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Таймеры', style: textTheme.navLargeTitleTextStyle),
                    SizedBox(height: 16),
                    TimerWheelPicker(
                      onTimerDurationChanged: (duration) =>
                          context.read<EditTimerBloc>().add(EditTimerDurationChanged(duration)),
                    ),
                    TimerControlButtons(onPressed: () => context.read<EditTimerBloc>().add(EditTimerSubmitted())),
                    TimerEditPanel(),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: Text('Недавние')),
              RecentTimersOverviewList(),
              SliverToBoxAdapter(child: Text('Активные')),
              ActiveTimersOverviewList(),
            ],
          ),
        ),
      ),
    );
  }
}
