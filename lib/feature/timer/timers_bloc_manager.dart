import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/ticker.dart';

class TimersBlocManager {
  final Map<String,TimerBloc> blocsMap = {};

  TimerBloc getBloc(TimerModel timer) {
    return blocsMap.putIfAbsent(timer.id, () => TimerBloc(initDuration: timer.duration, ticker: const Ticker()));
  }

  void removeBloc(TimerModel timer) {
    final bloc = blocsMap.remove(timer.id);
    bloc?.close();
  }
}