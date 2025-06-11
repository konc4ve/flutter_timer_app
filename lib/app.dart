import 'package:flutter/material.dart';

import 'package:flutter_timer_app/feature/timer/timers_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_list_page/timer_list_page.dart';
import 'package:flutter_timer_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimersListNotifier(),
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: TimerListPage(),
      ),
    );
  }
}
