import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/app/app.dart';
import 'package:flutter_timer_app/app/app_bloc_observer.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';

void bootstrap({
  required RecentTimersOverviewDataProviderImpl
  recentTimersOverviewDataProviderImp,
  required ActiveTimersOverviewDataProviderImpl
  activeTimersOverviewDataProviderImpl,
}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  final recentTimersOverviewRepo = RecentTimersOverviewRepositoryImpl(
    recentTimersOverviewDataProviderImp,
  );

  final activeTimersOverviewRepo = ActiveTimersOverviewRepositoryImpl(
    activeTimersOverviewDataProviderImpl,
  );

  Bloc.observer = const AppBlocObserver();

  runApp(
    App(
      createRecentTimersRepository: () => recentTimersOverviewRepo,
      createActiveTimersRepository: () => activeTimersOverviewRepo,
    ),
  );
}
