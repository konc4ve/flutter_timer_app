part of 'timer_bloc.dart';

sealed class TimerEvent {
  const TimerEvent();
}

final class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final Duration duration;
}

final class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration});
  final Duration duration;

}

