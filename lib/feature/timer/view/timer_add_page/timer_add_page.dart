import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_present_repository.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_add_page/widget/timer_creation_view.dart';
import 'package:uuid/uuid.dart';


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
    final isButtonEnabled = duration > 0;

    return Scaffold(
      appBar: AppBar(title: Text('Таймер', style: TextStyle(fontWeight: FontWeight.bold),),
      leading: IconButton(onPressed: Navigator.of(context).pop, icon: Icon(Icons.arrow_back, color: Colors.amber,)),
      actions: [
            TextButton(onPressed: isButtonEnabled ? () async{
                final uuid = Uuid();
                final timer = TimerModel(id: uuid.v4(),duration: duration, createdAt: DateTime.now());
                context.read<TimerPresentRepository>()
                  ..addTimer(timer)
                  ..runTimer(timer);
                Navigator.pop(context);
            } : null,
          child: Text('Запустить')),
      ],   
    ),
    body: TimerCreationView(onTimeChanged: _onTimeChanged,),
    );
  }
}
