
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<TimerDatabase>(() => TimerDatabase());
}