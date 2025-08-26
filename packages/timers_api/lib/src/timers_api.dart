import 'package:timers_api/src/models/timer.dart';

abstract interface class TimersApi {
  const TimersApi();

  Stream<List<Timer>> getTimers();

  Future<void> saveTimer(Timer timer);

  Future<void> deleteTimer(String id);

  Future<void> close();

}

class TimerNotFoundException implements Exception {
} 