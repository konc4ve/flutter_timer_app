import 'package:drift/drift.dart';
import 'package:flutter_timer_app/core/database/database.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/models/recent_timer_entity.dart';

abstract interface class RecentTimersOverviewRepository {
  Stream<List<RecentTimerEntity>> watchTimers();

  Future<void> saveRecentTimer(RecentTimerEntity timer);

  Future<void> updateRecentTimer(RecentTimerEntity updatedTimer);

  Future<void> deleteRecentTimer(String id);

  Future<void> dispose();
}

class RecentTimersOverviewRepositoryImpl
    implements RecentTimersOverviewRepository {
  RecentTimersOverviewRepositoryImpl(AppDatabase db) : _db = db;

  final AppDatabase _db;

  @override
  Stream<List<RecentTimerEntity>> watchTimers() {
    return _db
        .select(_db.recentTimers)
        .watch()
        .map((rows) => rows.map(RecentTimerEntity.fromDb).toList());
  }

  @override
  Future<void> saveRecentTimer(RecentTimerEntity timer) async {
    await _db
        .into(_db.recentTimers)
        .insert(timer.toInsertCompanion(), mode: InsertMode.insertOrReplace);
  }

  @override
  Future<void> updateRecentTimer(RecentTimerEntity updatedTimer) async {
    final count =
        await (_db.update(_db.recentTimers)
              ..where((t) => t.id.equals(updatedTimer.id)))
            .write(updatedTimer.toUpdateCompanion());

    if (count == 0) {
      throw RecentTimerNotFoundException();
    }
  }

  @override
  Future<void> deleteRecentTimer(String id) async {
    final count = await (_db.delete(
      _db.recentTimers,
    )..where((t) => t.id.equals(id))).go();

    if (count == 0) {
      throw RecentTimerNotFoundException();
    }
  }

  @override
  Future<void> dispose() => _db.close();
}

class RecentTimerNotFoundException implements Exception {}
