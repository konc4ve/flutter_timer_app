import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/feature/timer/bloc/timers_list/timers_list_bloc.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_list_page/timer_list_page.dart';
import 'package:flutter_timer_app/theme/app_theme.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimersListBloc(),
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: TimerListPage(),
      ),
    );
  }
}
