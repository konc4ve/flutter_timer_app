import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_run_page/timer_run_page.dart';


class TimerListTile extends StatelessWidget {
  final TimerModel timer;
  final TimerState? timerState;
  final TimerBloc? timerBloc;
  const TimerListTile({
    super.key,
    required this.timer,
    this.timerState,
    this.timerBloc,
  });

  @override
  Widget build(BuildContext context) {
    final activeMode = timerState != null || timerBloc != null;
    final String label = timer.label;

    return ListTile(
      onTap: (activeMode) ? () {
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(
        value: timerBloc!,
        child: TimerRunPage(maxDuration: timerBloc!.initDuration,),
      )));
      } : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: (activeMode) ? Text("${timerState!.duration.toString()} $label"
          ,
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 203, 199, 199))) :
              Text(
          "${timer.duration.toString()} $label",
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 203, 199, 199))),
      trailing: (activeMode) ? BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if (state is TimerRunInProgress) {
            return IconButton(
              onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerPaused()),
              icon: Icon(
                Icons.pause_outlined,
                color: Colors.amber,
              ));
          }
          if (state is TimerRunPause) {
            return IconButton(
              onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
              icon: Icon(
                Icons.play_arrow,
                color: Colors.amber,
              ));
          }
          if (state is TimerInitial) {
            return IconButton(
              onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
              icon: Icon(
                Icons.play_arrow,
                color: Colors.amber,
              ));
          }
          return Text("ВАСАП");
        },
      ) : 
      IconButton(onPressed: () {
        context.read<TimerManager>().createAndRunTimer(timer: timer, saveToDb: false);
      }, icon: Icon(Icons.play_arrow,color: Colors.amber,)),
    );
  }
}
