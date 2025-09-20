import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/common/common.dart';
import 'package:flutter_timer_app/common/widgets/timer_control_buttons.dart';
import 'package:flutter_timer_app/common/widgets/timer_edit_panel/timer_edit_panel.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/edit_timer/edit_timer.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';
import 'package:flutter_timer_app/screens/timer_edit_screen.dart';


class TimersOverviewScreen extends StatelessWidget {
  const TimersOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTimerBloc(
        activeTimersOverviewRepository: context
            .read<ActiveTimersOverviewRepository>(),
        recentTimersOverviewRepository: context
            .read<RecentTimersOverviewRepository>(),
        initialTimer: null,
      ),
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
    return CupertinoPageScaffold(
      child: SlidableAutoCloseBehavior(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              padding: EdgeInsetsDirectional.zero,
              largeTitle: Text('Таймеры'),
              alwaysShowMiddle: false,
              middle: Text('Таймеры'),
              trailing:
                  BlocSelector<
                    ActiveTimersOverviewBloc,
                    ActiveTimersOverviewState,
                    List<ActiveTimer>
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
            BlocBuilder<ActiveTimersOverviewBloc, ActiveTimersOverviewState>(
              builder: (context, state) {
                if (state.activeTimers.isEmpty) {
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
                          TimerControlButtons(
                            onPressed: () {
                              context.read<EditTimerBloc>().add(
                                EditTimerSubmitted(),
                              );
                              context.read<EditTimerBloc>().add(
                                EditTimerReset(),
                              );
                              _controller.clear();
                            },
                          ),
                          const SizedBox(height: 20),
                          TimerEditPanel(controller: _controller),
                        ],
                      ),
                    ),
                  );
                }
                return ActiveTimersOverviewList();
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            RecentTimersOverviewListView(),
          ],
        ),
      ),
    );
  }
}
