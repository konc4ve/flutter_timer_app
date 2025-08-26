import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';

import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';
import 'package:flutter_timer_app/screens/timers_overview_screen.dart';
import 'package:flutter_timer_app/theme/theme.dart';

class App extends StatelessWidget {
  final RecentTimersOverviewRepository Function() createRecentTimersRepository;
  final ActiveTimersOverviewRepository Function() createActiveTimersRepository;

  const App({
    required this.createRecentTimersRepository,
    required this.createActiveTimersRepository,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => createRecentTimersRepository(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(
          create: (_) => createActiveTimersRepository(),
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      supportedLocales: [Locale('en'), Locale('ru')],

      locale: const Locale('ru', 'RU'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: TimersTheme.dark,
      home: const TimersOverviewScreen(),
    );
  }
}
