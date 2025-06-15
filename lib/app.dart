import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_present_repository.dart';

import 'package:flutter_timer_app/feature/timer/timers_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_list_page/timer_list_page.dart';
import 'package:flutter_timer_app/feature/timers_bloc_manager.dart';
import 'package:flutter_timer_app/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GetIt.instance.get<TimerPresentRepository>()),
        ChangeNotifierProvider(create: (_) => GetIt.instance.get<TimersListNotifier>()),
        Provider(create: (_) => TimersBlocManager()),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: TimerListPage(),
      ),
    );
  }
}
