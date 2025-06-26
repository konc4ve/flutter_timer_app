import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/timer_editor_model.dart';

import 'package:flutter_timer_app/feature/timer/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_list_page/timer_list_page.dart';
import 'package:flutter_timer_app/feature/timer/timers_bloc_manager.dart';
import 'package:flutter_timer_app/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => TimersBlocManager()),
        Provider(create: (_) => GetIt.instance.get<TimerManager>()),
        ChangeNotifierProvider(create: (_) => GetIt.instance.get<TimerRecentListNotifier>()),
        ChangeNotifierProvider(create: (_) => GetIt.instance.get<TimerActiveListNotifier>()),
        ChangeNotifierProvider(create: (_) => GetIt.instance.get<TimerEditorModel>()),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: TimerListPage(),
      ),
    );
  }
}
