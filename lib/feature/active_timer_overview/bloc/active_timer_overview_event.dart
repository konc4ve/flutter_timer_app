part of 'active_timer_overview_bloc.dart';

sealed class ActiveTimerOverviewEvent {
  const ActiveTimerOverviewEvent();
}

final class ActiveTimerStarted extends ActiveTimerOverviewEvent {
  const ActiveTimerStarted();
}

final class ActiveTimerPaused extends ActiveTimerOverviewEvent {
  const ActiveTimerPaused();
}

class _ActiveTimerTicked extends ActiveTimerOverviewEvent {
  const _ActiveTimerTicked({required this.duration});
  final Duration duration;

}

