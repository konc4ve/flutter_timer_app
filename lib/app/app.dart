import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/tab_scaffold.dart';

import 'package:flutter_timer_app/theme/theme.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActiveTimersOverviewBloc(
        GetIt.I<ActiveTimersOverviewRepository>(),
      ),
      child: CupertinoApp(
        supportedLocales: [Locale('en'), Locale('ru')],
        locale: const Locale('ru', 'RU'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: TimersTheme.dark,
        home: TabScaffold(),
      ),
    );
  }
}
