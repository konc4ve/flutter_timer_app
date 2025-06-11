import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/timers_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/widget/timer_creation_view.dart';


class TimerAddPage extends StatefulWidget {
  const TimerAddPage({super.key});

  @override
  State<TimerAddPage> createState() => _TimerAddPageState();
}

class _TimerAddPageState extends State<TimerAddPage> {
  int duration = 0;
  void _onTimeChanged(int h, int m, int s) {
    setState(() {
      duration = h * 3600 + m * 60 + s;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = duration >0;

    return Scaffold(
      appBar: AppBar(title: Text('Таймер', style: TextStyle(fontWeight: FontWeight.bold),),
      leading: IconButton(onPressed: Navigator.of(context).pop, icon: Icon(Icons.arrow_back, color: Colors.amber,)),
      actions: [
            TextButton(onPressed: isButtonEnabled ? () {
                final notifier = context.read<TimersListNotifier>();
                notifier.addTimer(TimerModel(duration: duration, createdAt: DateTime.now()));
                Navigator.pop(context);
            } : null,
          child: Text('Запустить')),
      ],   
    ),
    body: TimerCreationView(onTimeChanged: _onTimeChanged,),
    );
  }
}
