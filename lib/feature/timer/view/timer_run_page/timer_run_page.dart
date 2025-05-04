import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';

class TimerRunPage extends StatelessWidget {
  final TimerModel timer;
  const TimerRunPage({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Таймер Ран'),
        leading: IconButton(onPressed: () {Navigator.pop(context);} , icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if (state is TimerRunInProgress) {
            return Column(
              children: [
                Center(
                  child: Text(
                timer.formattedTime,
                style: TextStyle(fontSize: 50),
                  )
                ),
                FloatingActionButton(onPressed: () => ' ', child: Icon(Icons.pause),)

            ],
            );
          }
        return Text('ТАймер на паузе');
        },
      ),
    );
  }
}
