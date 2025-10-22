import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/timers/common/common.dart';
import 'package:flutter_timer_app/timers/common/widgets/new_timer_buttons.dart';
import 'package:flutter_timer_app/timers/common/widgets/timer_edit_panel/timer_edit_panel.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/edit_timer.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/bloc/recent_timers_overview_bloc.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/data/recent_timers_overview_repository.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/view/recent_timers_overview_list.dart';
import 'package:flutter_timer_app/timers/screens/timer_edit_screen.dart';
import 'package:get_it/get_it.dart';

class TimersOverviewScreen extends StatelessWidget {
  const TimersOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditTimerBloc(
            activeTimersOverviewRepository:
                GetIt.I<ActiveTimersOverviewRepository>(),
            recentTimersOverviewRepository:
                GetIt.I<RecentTimersOverviewRepository>(),
            initialTimer: null,
          ),
        ),
        BlocProvider(
          create: (context) => ActiveTimersOverviewBloc(
            GetIt.I<ActiveTimersOverviewRepository>(),
          )..add(ActiveTimersOverviewSubscriptionRequested()),
        ),
        BlocProvider(
          create: (context) => RecentTimersOverviewBloc(
            GetIt.I<RecentTimersOverviewRepository>(),
          )..add(RecentTimersOverviewSubscriptionRequested()),
        ),
      ],
      child: TimersOverviewScreenView(),
    );
  }
}

class TimersOverviewScreenView extends StatefulWidget {
  const TimersOverviewScreenView({super.key});

  @override
  State<TimersOverviewScreenView> createState() =>
      _TimersOverviewScreenViewState();
}

class _TimersOverviewScreenViewState extends State<TimersOverviewScreenView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(
      () => context.read<EditTimerBloc>().add(
        EditTimerLabelChanged(_controller.text),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: CustomScrollView(
        // physics: ClampingScrollPhysics(),
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: Colors.black,
            padding: EdgeInsetsDirectional.zero,
            largeTitle: Text('Таймеры'),
            alwaysShowMiddle: false,
            middle: Text('Таймеры'),
            trailing:
                BlocSelector<
                  ActiveTimersOverviewBloc,
                  ActiveTimersOverviewState,
                  List<ActiveTimerEntity>
                >(
                  selector: (state) => state.activeTimers,
                  builder: (context, activeTimers) {
                    if (activeTimers.isNotEmpty) {
                      return IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => TimerEditScreen(),
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.add,
                          color: CupertinoColors.activeOrange,
                          size: 30,
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
          ),
          BlocSelector<
            ActiveTimersOverviewBloc,
            ActiveTimersOverviewState,
            List<ActiveTimerEntity>
          >(
            selector: (state) => state.activeTimers,
            builder: (context, activeTimers) {
              if (activeTimers.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TimerWheelPicker(
                          onTimerDurationChanged: (duration) => context
                              .read<EditTimerBloc>()
                              .add(EditTimerDurationChanged(duration)),
                        ),
                        NewTimerButtons(
                          onStartPressed: () {
                            context.read<EditTimerBloc>().add(
                              EditTimerSubmitted(),
                            );
                            _controller.clear();
                          },
                        ),
                        const SizedBox(height: 20),
                        TimerEditPanel(
                          editTimerBloc: context.read<EditTimerBloc>(),
                          controller: _controller,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ActiveTimersOverviewList();
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 40)),
          RecentTimersOverviewList(),
        ],
      ),
    );
  }
}
