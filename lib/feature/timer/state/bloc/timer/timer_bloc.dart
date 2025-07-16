import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/timer/ticker.dart';


part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  final Duration initDuration;
  final Ticker _ticker;
  StreamSubscription<Duration>? _tickerSubscription;

  TimerBloc({required this.initDuration, required Ticker ticker})  : _ticker = ticker, super(TimerInitial(initDuration)) {
    on<TimerStarted>(_onTimerStart);
    on<_TimerTicked>(_onTimerTicked);
    on<TimerPaused>(_onTimerPaused);
    on<TimerReset>(_onTimerReset);
  }
  

  void _onTimerReset (TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerInitial(initDuration));
  }

  void _onTimerStart(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(duration: event.duration).listen((duration) => add(_TimerTicked(duration: duration)));
}

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription!.pause();
      emit(TimerRunPause(state.duration));
    }
  }


  void _onTimerTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration != Duration.zero 
    ? TimerRunInProgress(event.duration)
    : TimerRunComplete()
    );
  }

@override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}