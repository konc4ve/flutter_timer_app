import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/timers/feature/active_timer_overview/data/timer_controller.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/data/active_timers_overview_repository.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'active_timer_overview_event.dart';
part 'active_timer_overview_state.dart';

class ActiveTimerOverviewBloc
    extends Bloc<ActiveTimerOverviewEvent, ActiveTimerOverviewState> {
  ActiveTimerOverviewBloc({
    required activeTimersOverviewRepository,
    required this.timer,
    required StopWatchTimer stopWatchTimer,
  }) : _timerController = TimerController(stopWatchTimer: stopWatchTimer),
       _activeTimersOverviewRepository = activeTimersOverviewRepository,

       super(ActiveTimerOverviewInitial(timer.remainDuration)) {
    on<ActiveTimerStarted>(_onTimerStarted);
    on<_ActiveTimerTicked>(_onTimerTicked);
    on<ActiveTimerPaused>(_onTimerPaused);

    if (timer.isRunning) {
      add(ActiveTimerStarted());
    }
  }

  final ActiveTimersOverviewRepository _activeTimersOverviewRepository;

  final TimerController _timerController;

  StreamSubscription<int>? _timerSubscription;

  final ActiveTimerEntity timer;

  void _onTimerStarted(
    ActiveTimerStarted event,
    Emitter<ActiveTimerOverviewState> emit,
  ) async {
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
    if (event.duration != Duration.zero) {
      emit(ActiveTimerOverviewRunInProgress(event.duration));
    } else {
      emit(ActiveTimerOverviewRunComplete());
      await _timerSubscription?.cancel();
      await _activeTimersOverviewRepository.deleteActiveTimer(timer.id);
    }
  }

  @override
  Future<void> close() async {
    await _timerSubscription?.cancel();
    _timerController.dispose();
    return super.close();
  }
}
