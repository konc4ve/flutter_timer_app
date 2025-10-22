import 'package:drift/drift.dart';
import 'package:flutter_timer_app/core/database/database.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';

abstract interface class ActiveTimersOverviewRepository {
  Stream<List<ActiveTimerEntity>> watchTimers();

  Future<void> saveActiveTimer(ActiveTimerEntity timer);

  Future<void> upDateActiveTimer(ActiveTimerEntity updatedTimer);

  Future<void> deleteActiveTimer(String id);

  Future<void> dispose();
}

class ActiveTimersOverviewRepositoryImpl
    implements ActiveTimersOverviewRepository {
  ActiveTimersOverviewRepositoryImpl(AppDatabase db) : _db = db;

  final AppDatabase _db;

  @override
  Stream<List<ActiveTimerEntity>> watchTimers() {
    return _db
        .select(_db.activeTimers)
        .watch()
        .map((rows) => rows.map(ActiveTimerEntity.fromDb).toList());
  }

  @override
  Future<void> saveActiveTimer(ActiveTimerEntity timer) async {
    await _db
        .into(_db.activeTimers)
        .insert(
          timer.toInsertCompanion(),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<void> deleteActiveTimer(String id) async {
    final deletedCount = await (_db.delete(
      _db.activeTimers,
    )..where((t) => t.id.equals(id))).go();

    if (deletedCount == 0) {
      throw ActiveTimerNotFoundException();
    }
  }

  @override
  Future<void> dispose() => _db.close();

  @override
  Future<void> upDateActiveTimer(ActiveTimerEntity updatedTimer) async {
    final updateCount =
        await (_db.update(_db.activeTimers)
              ..where((t) => t.id.equals(updatedTimer.id)))
            .write(updatedTimer.toUpdateCompanion());
    if (updateCount == 0) {
      throw ActiveTimerNotFoundException();
    }
  }
}

class ActiveTimerNotFoundException implements Exception {}
