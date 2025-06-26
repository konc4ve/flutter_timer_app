import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timer/timer_bloc.dart';



class TimerRunPage extends StatelessWidget {
  final int maxDuration; 

  const TimerRunPage({super.key, required this.maxDuration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Таймер Ран'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            if (state is TimerRunInProgress ||
                state is TimerRunPause ||
                state is TimerInitial) {
              final duration = state.duration;

              final progress = duration / maxDuration;

              return Column(
                children: [
                  SizedBox(height: 10,),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                      width: 350,
                      height: 350,
                      child: CircularProgressIndicator(
                        
                        strokeCap: StrokeCap.round,
                        value: progress.clamp(0.0, 1.0),
                        color: Colors.amber,
                        strokeWidth: 7,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 3,),
                          Text('10:39')
                        ],),
                        Text('00:05', style: TextStyle(fontSize: 90,fontWeight: FontWeight.w200),),
                      ],
                    ),
                    ]
                  ),
                  SizedBox(height: 20),
                  // TimerControlButtons(isCancelBtnEnable: false, duration: duration),
                  // TimerConfigurationPanel(onChanged: (text) {
                  // }),
                ],
              );
            }

            if (state is TimerRunComplete) {
              return Text(
                'Таймер завершён',
                style: TextStyle(fontSize: 28, color: Colors.white),
              );
            }

            return Text('...');
          },
        ),
      ),
    );
  }
}