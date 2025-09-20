import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/common/widgets/settings_sets.dart';
import 'package:flutter_timer_app/common/widgets/timer_edit_panel/timer_edit_panel.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/edit_timer/bloc/edit_timer_bloc.dart';
import 'package:flutter_timer_app/feature/edit_timer/widgets/timer_wheel_picker.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';

class TimerEditScreen extends StatelessWidget {
  const TimerEditScreen({super.key});

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
      child: TimerEditScreenView(),
    );
  }
}

class TimerEditScreenView extends StatefulWidget {
  const TimerEditScreenView({super.key});

  @override
  State<TimerEditScreenView> createState() => _TimerEditScreenViewState();
}

class _TimerEditScreenViewState extends State<TimerEditScreenView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      context.read<EditTimerBloc>().add(
        EditTimerLabelChanged(_controller.text),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Таймер'),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отменить'),
        ),
        trailing: BlocBuilder<EditTimerBloc, EditTimerState>(
          builder: (context, state) {
            return TextButton(
              onPressed: (state.duration > Duration.zero)
                  ? () {
                      context.read<EditTimerBloc>().add(EditTimerSubmitted());
                      context.read<EditTimerBloc>().add(EditTimerReset());
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('Запустить'),
            );
          },
        ),
      ),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  TimerWheelPicker(
                    onTimerDurationChanged: (duration) => context
                        .read<EditTimerBloc>()
                        .add(EditTimerDurationChanged(duration)),
                  ),
                  const SizedBox(height: 20),
                  TimerEditPanel(controller: _controller),
                  const SizedBox(height: 30),
                  Text(
                    'Наборы настроек',
                    style: theme.textTheme.actionSmallTextStyle,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsSets(
              onTap: (duration) {
                context.read<EditTimerBloc>().add(
                  EditTimerDurationChanged(duration),
                );
                context.read<EditTimerBloc>().add(EditTimerSubmitted());
                Navigator.pop(context);
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SlidableAutoCloseBehavior(
            child: RecentTimersOverviewListView(
              onAction: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
