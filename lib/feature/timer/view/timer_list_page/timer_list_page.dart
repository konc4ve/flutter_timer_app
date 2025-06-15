import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_present_repository.dart';
import 'package:flutter_timer_app/feature/timer/timers_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/timer_add_page.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/widget/timer_creation_view.dart';



class TimerListPage extends StatefulWidget {
  const TimerListPage({super.key});

  @override
  State<TimerListPage> createState() => _TimerListPageState();
}

class _TimerListPageState extends State<TimerListPage> {
  @override
  void initState() {
    
    super.initState();
    context.read<TimerPresentRepository>().loadTimers();
    
  }

  @override
  Widget build(BuildContext context) {
    final timersNotifier = context.watch<TimersListNotifier>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Таймеры',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const TimerAddPage(),
                      maintainState: true),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            TimerCreationView(onTimeChanged: onTimeChanged),
            ListenableBuilder(
                listenable: timersNotifier,
                builder: (context, child) {
                  final timers = timersNotifier.timersList;
                  return ListView.builder(
                    itemCount: timers.length,
                    itemBuilder: (context, index) {              
                      final timer = timers[index];
                      final bloc = context.read<TimerPresentRepository>().getBloc(timer);
                      return Dismissible(
                        key: ValueKey(timer.id),
                        onDismissed: (direction) {
                          context.read<TimerPresentRepository>().removeTimer(timer);
                        },
                        child:BlocProvider.value(
                          value: bloc,
                          child:BlocBuilder<TimerBloc, TimerState>(
                              builder: (context, state) {
                              if (state is! TimerRunComplete) {
                                final h = state.duration ~/ 3600;
                                final m = (state.duration % 3600) ~/ 60;
                                final s = state.duration % 60;
                                return TimerListTile(hours: h, mins: m, secs: s);
                              }
                              return const SizedBox.shrink();
                            },
                        ),     
                          ),
                 
                      );
                    },
                  );
                }),
          ],
        ));
  }
}

class TimerListTile extends StatelessWidget {
  const TimerListTile({
    super.key,
    required this.hours,
    required this.mins,
    required this.secs,
  });

  final int hours;
  final int mins;
  final int secs;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${hours.toString().padLeft(2, '0')}:'
          '${mins.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}',
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 203, 199, 199))),
      trailing: BlocBuilder<TimerBloc, TimerState>(
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
      ),
    );
  }
}
