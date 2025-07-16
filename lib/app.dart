import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/state/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_editor_model.dart';

import 'package:flutter_timer_app/feature/timer/state/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/timer_home_page.dart';
import 'package:flutter_timer_app/feature/timer/state/timers_bloc_manager.dart';
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
      child: CupertinoApp(
        supportedLocales: [
          Locale('en'),
          Locale('ru'), 
        ],
        locale: const Locale('ru', 'RU'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(textStyle: TextStyle(decoration: TextDecoration.none))
        ),
        home: TimerHomePage(),
      ),
    );
  }
}
