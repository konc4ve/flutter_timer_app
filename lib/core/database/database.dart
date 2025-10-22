import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class ActiveTimers extends Table {
  TextColumn get alarmMelody => text()();
  TextColumn get id => text()();
  TextColumn get label => text()();
  BoolColumn get isRunning => boolean()();
  IntColumn get remainDuration => integer().map(const DurationConverter())();
  IntColumn get setDuration => integer().map(const DurationConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class RecentTimers extends Table {
  TextColumn get alarmMelody => text()();
  TextColumn get id => text()();
  TextColumn get label => text()();
  IntColumn get setDuration => integer().map(const DurationConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class DurationConverter extends TypeConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromSql(int fromDb) => Duration(milliseconds: fromDb);

  @override
  int toSql(Duration value) => value.inMilliseconds;
}

@DriftDatabase(tables: [ActiveTimers, RecentTimers])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
