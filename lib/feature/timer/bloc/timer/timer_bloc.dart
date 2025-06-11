import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/timer/ticker.dart';


part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  final int initDuration;
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required this.initDuration, required Ticker ticker})  : _ticker = ticker, super(TimerInitial(initDuration)) {
    on<TimerStarted>(_onTimerStart);
    on<_TimerTicked>(_onTimerTicked);
    on<TimerPaused>(_onTimerPaused);
  }
  

  void _onTimerStart(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen((duration) => add(_TimerTicked(duration: duration)));
}

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription!.pause();
      emit(TimerRunPause(state.duration));
    }
  }


  void _onTimerTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0 
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