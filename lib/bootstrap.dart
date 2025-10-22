import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/app/app.dart';
import 'package:flutter_timer_app/app/app_bloc_observer.dart';
import 'package:flutter_timer_app/core/database/database.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/data/recent_timers_overview_repository.dart';
import 'package:flutter_timer_app/timers/services/alarm_player.dart';
import 'package:get_it/get_it.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  Bloc.observer = const AppBlocObserver();

  final getIt = GetIt.instance;

  getIt.registerSingleton<AppDatabase>(AppDatabase());

  getIt.registerSingleton<ActiveTimersOverviewRepository>(
    ActiveTimersOverviewRepositoryImpl(getIt<AppDatabase>()),
  );

  getIt.registerSingleton<RecentTimersOverviewRepository>(
    RecentTimersOverviewRepositoryImpl(getIt<AppDatabase>()),
  );

  getIt.registerSingleton<AlarmPlayer>(AlarmPlayer(player: AudioPlayer()));

  runApp(App());
}
