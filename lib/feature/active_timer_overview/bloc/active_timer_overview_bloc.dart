import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/active_timer_overview/data/timer_controller.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'active_timer_overview_event.dart';
part 'active_timer_overview_state.dart';

class ActiveTimerOverviewBloc
    extends Bloc<ActiveTimerOverviewEvent, ActiveTimerOverviewState> {
  final TimerController _timerController;
  StreamSubscription<int>? _timerSubscription;
  final Duration initDuration;

  ActiveTimerOverviewBloc({
    required this.initDuration,
    required StopWatchTimer stopWatchTimer,
  }) : _timerController = TimerController(stopWatchTimer: stopWatchTimer),
       super(ActiveTimerOverviewRunInProgress(initDuration)) {
    on<ActiveTimerStarted>(_onTimerStart);
    on<_ActiveTimerTicked>(_onTimerTicked);
    on<ActiveTimerPaused>(_onTimerPaused);
  }

  void _onTimerStart(
    ActiveTimerStarted event,
    Emitter<ActiveTimerOverviewState> emit,
  ) {
    _timerSubscription?.cancel();
       _timerSubscription = _timerController.time.listen(
      (seconds) =>
          add(_ActiveTimerTicked(duration: Duration(seconds: seconds))),
    );
    _timerController.start();
  }

  void _onTimerPaused(
    ActiveTimerPaused event,
    Emitter<ActiveTimerOverviewState> emit,
  ) {
    if (state is ActiveTimerOverviewRunInProgress) {
      _timerController.pause();
      emit(ActiveTimerOverviewRunPause(state.duration));
    }
  }

  Future<void> _onTimerTicked(
    _ActiveTimerTicked event,
    Emitter<ActiveTimerOverviewState> emit,
  ) async {
    emit(
      event.duration != Duration.zero
          ? ActiveTimerOverviewRunInProgress(event.duration)
          : ActiveTimerOverviewRunComplete(),
    );

  }

  @override
  Future<void> close() {
    _timerController.dispose();
    return super.close();
  }
}
