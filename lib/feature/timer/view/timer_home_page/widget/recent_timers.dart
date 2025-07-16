import 'package:flutter/cupertino.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/state/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/slidable_timer_list_tile/slidable_timer_list_tile.dart';

class RecentTimers extends StatelessWidget {
  const RecentTimers({
    super.key,
    required this.timersRecentNotifier,
    required this.recentTimers,
  });

  final TimerRecentListNotifier timersRecentNotifier;
  final List<TimerModel> recentTimers;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: timersRecentNotifier,
        builder: (context, child) {
          return ListView.builder(
              itemCount: recentTimers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final timer = recentTimers[index];
                return SlidableTimerListTile(
                  timer: timer,
                  type: TimerType.recent,
                );
              });
        });
  }
}

