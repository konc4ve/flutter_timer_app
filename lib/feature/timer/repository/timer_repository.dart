import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';

class TimerRepository {
  final TimerDatabase _db;
  TimerRepository(this._db);

  Future<List<TimerModel>> getTimers() => _db.timersList();
  
  Future<void> addTimer(TimerModel timer) => _db.insertTimer(timer);
  Future<void> deleteTimer(TimerModel timer) => _db.deleteTimer(timer);
}