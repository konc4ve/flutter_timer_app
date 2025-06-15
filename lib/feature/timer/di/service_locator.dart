
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_present_repository.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_repository.dart';
import 'package:flutter_timer_app/feature/timer/timers_list_notifier.dart';
import 'package:flutter_timer_app/feature/timers_bloc_manager.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton<TimerDatabase>(() => TimerDatabase());

  getIt.registerLazySingleton<TimersListNotifier>(() => TimersListNotifier());
  
  getIt.registerLazySingleton<TimersBlocManager>(() => TimersBlocManager());

  getIt.registerLazySingleton<TimerRepository>(
      () => TimerRepository(getIt<TimerDatabase>()),
    );

  getIt.registerLazySingleton(() => TimerPresentRepository(
    notifier: getIt<TimersListNotifier>(),
    db: getIt<TimerDatabase>(),
    blocManager: getIt<TimersBlocManager>(),
    ));
}