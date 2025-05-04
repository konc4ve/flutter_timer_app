import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timers_list/timers_list_bloc.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/widget/timer_creation_view.dart';

class TimerAddView extends StatefulWidget {
  const TimerAddView({super.key});

  @override
  State<TimerAddView> createState() => _TimerAddViewState();
}

class _TimerAddViewState extends State<TimerAddView> {
  int duration = 0;

  void _onTimeChanged(int h, int m, int s) {
    duration = h * 3600 + m * 60 + s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Таймер', style: TextStyle(fontWeight: FontWeight.bold),),
      leading: IconButton(onPressed: Navigator.of(context).pop, icon: Icon(Icons.arrow_back, color: Colors.amber,)),
      actions: [
        TextButton(onPressed: () {
        context.read<TimersListBloc>().add(AddTimer(duration: duration));
        Navigator.pop(context);
        },
        child: Text('Запустить'))
      ],   
    ),
    body: TimerCreationView(onTimeChanged: _onTimeChanged,),
    );
  }
}
