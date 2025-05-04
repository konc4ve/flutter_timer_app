import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timers_list/timers_list_bloc.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/timer_add_page.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_list_page/widget/timer_scope.dart';

class TimerListView extends StatefulWidget {
  const TimerListView({super.key});

  @override
  State<TimerListView> createState() => _TimerListViewState();
}

class _TimerListViewState extends State<TimerListView> {
  @override
  void initState() {
    super.initState();
    context.read<TimersListBloc>().add(LoadTimersList());
  }

  @override
  Widget build(BuildContext context) {
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
                  maintainState: true
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      body: BlocBuilder<TimersListBloc, TimersListState>(
        builder: (context, state) {
          if (state is LoadTimersListInProgress) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (state is LoadTimersListSuccess) {
            final timers = state.timersList;
          
          if (timers.isEmpty) {
            return const Center(child: Text('Нет запущенных таймеров'));
          }

            return ListView.builder(
              itemCount: timers.length,
              itemBuilder: (context, index) {
                final timer = timers[index];
                return TimerScope(
                  key: ValueKey(timer.id),
                  timer: timer,
                  child: BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      if (state is TimerRunInProgress){
                        final h = state.duration ~/ 3600;
                        final m = (state.duration % 3600) ~/ 60;
                        final s = state.duration % 60;
                        return TimerListTile(hours: h, mins: m, secs: s);
                      }
                      return const Text('ТРЫНДА');
                    },
                  ),
                );
              },
            );
          } 
          else if (state is LoadTimersListFailure) {
            return Center(child: Text('Ошибка: ${state.error}'));
          } 
          else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
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
      title: Text('${hours.toString().padLeft(2, '0')}:'
                  '${mins.toString().padLeft(2, '0')}:'
                  '${secs.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300, color: const Color.fromARGB(255, 203, 199, 199))),
      trailing: IconButton(onPressed: () => '', icon: Icon(Icons.play_arrow, color: Colors.amber,)),
                          );
  }
}