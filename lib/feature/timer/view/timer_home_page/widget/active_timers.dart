import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/state/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/state/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/slidable_timer_list_tile/slidable_timer_list_tile.dart';

class ActiveTimers extends StatelessWidget {
  const ActiveTimers({
    super.key,
    required this.timersActiveNotifier,
    required this.runningTimers,
    required this.timerManager,
  });

  final TimerActiveListNotifier timersActiveNotifier;
  final List<TimerModel> runningTimers;
  final TimerManager timerManager;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: timersActiveNotifier,
      builder: (context, child) {
        if (runningTimers.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: runningTimers.length,
            itemBuilder: (context, index) {
              final timer = runningTimers[index];
              final bloc = context
                  .read<TimerManager>()
                  .blocManager
                  .getBloc(timer);
              return BlocProvider.value(
                value: bloc,
                child: BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                  if (state is! TimerRunComplete) {
                    return SlidableTimerListTile(
                      timer: timer,
                      type: TimerType.active,
                    );
                  } else {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) {
                      timerManager.removeActiveTimer(timer);
                    });
                    return SlidableTimerListTile(
                      timer: timer,
                      type: TimerType.active,
                    );
                  }
                }),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
