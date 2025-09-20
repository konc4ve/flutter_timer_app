import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/active_timer_overview/data/timer_controller.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/data/active_timers_overview_repository.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/models/models.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/service/active_timer_bloc_manager.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'active_timer_overview_event.dart';
part 'active_timer_overview_state.dart';

class ActiveTimerOverviewBloc
    extends Bloc<ActiveTimerOverviewEvent, ActiveTimerOverviewState> {
  final ActiveTimersOverviewRepository _activeTimersOverviewRepository;
  final TimerController _timerController;
  StreamSubscription<int>? _timerSubscription;
  final ActiveTimer timer;
  final ActiveTimersBlocManager _activeTimersBlocManager;

  ActiveTimerOverviewBloc({
    required ActiveTimersBlocManager manager,
    required activeTimersOverviewRepository,
    required this.timer,
    required StopWatchTimer stopWatchTimer,
  }) : _timerController = TimerController(stopWatchTimer: stopWatchTimer),
       _activeTimersOverviewRepository = activeTimersOverviewRepository,
       _activeTimersBlocManager = manager,
       super(ActiveTimerOverviewRunInProgress(timer.duration)) {
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
    final newRemain = event.duration;

    if (newRemain != Duration.zero) {
      final updatedActiveTimer = timer.copyWith(remainDuration: newRemain);

      emit(ActiveTimerOverviewRunInProgress(newRemain));

      await _activeTimersOverviewRepository.upDateActiveTimer(
        updatedActiveTimer,
      );
    } else {
      emit(ActiveTimerOverviewRunComplete());
      await _activeTimersOverviewRepository.deleteActiveTimer(timer.id);
      _activeTimersBlocManager.dispose(timer.id);
    }
  }

  @override
  Future<void> close() {
    _timerController.dispose();
    return super.close();
  }
}
