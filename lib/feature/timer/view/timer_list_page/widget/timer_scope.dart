import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/ticker.dart';

class TimerScope extends StatefulWidget {
  final TimerModel timer;
  final Widget child;
  const TimerScope({super.key, required this.child, required this.timer});

  @override
  State<TimerScope> createState() => _TimerScopeState();
}

class _TimerScopeState extends State<TimerScope> with AutomaticKeepAliveClientMixin{
  late final Ticker _ticker;
  late final TimerBloc _bloc;

  @override
  void initState() {
    _ticker = const Ticker();
    _bloc = TimerBloc(initDuration: widget.timer.duration, ticker: _ticker);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _bloc,
      child: widget.child,
      );
  }
   @override
  bool get wantKeepAlive => true;
}