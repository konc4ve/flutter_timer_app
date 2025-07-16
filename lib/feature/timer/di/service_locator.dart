
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_repository.dart';
import 'package:flutter_timer_app/feature/timer/state/timer_active_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_editor_model.dart';
import 'package:flutter_timer_app/feature/timer/state/timers_recent_list_notifier.dart';
import 'package:flutter_timer_app/feature/timer/state/timers_bloc_manager.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton<TimerDatabase>(() => TimerDatabase());

  getIt.registerLazySingleton<TimerRecentListNotifier>(() => TimerRecentListNotifier());
  
  getIt.registerLazySingleton<TimerActiveListNotifier>(() => TimerActiveListNotifier());
  
  getIt.registerLazySingleton<TimerEditorModel>(() => TimerEditorModel());

  getIt.registerLazySingleton<TimersBlocManager>(() => TimersBlocManager());

  getIt.registerLazySingleton<TimerRepository>(
      () => TimerRepository(getIt<TimerDatabase>()),
    );

  getIt.registerLazySingleton(() => TimerManager(
    timerEditorModel: getIt<TimerEditorModel>(),
    activeNotifier: getIt<TimerActiveListNotifier>(),
    recentNotifier: getIt<TimerRecentListNotifier>(),
    db: getIt<TimerDatabase>(),
    blocManager: getIt<TimersBlocManager>(),
    ));
}