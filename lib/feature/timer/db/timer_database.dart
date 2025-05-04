import 'dart:async';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TimerDatabase {
  static final TimerDatabase _instance = TimerDatabase.internal();

  factory TimerDatabase() => _instance;

  TimerDatabase.internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'timer.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE timers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        duration INTEGER,
        label TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      // Создание новой таблицы без isRunning и с duration
      await db.execute('''
        CREATE TABLE timers_new (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          duration INTEGER,
          label TEXT,
          createdAt TEXT
        )
      ''');

      // Переносим данные из старой таблицы в новую
      await db.execute('''
        INSERT INTO timers_new (id, duration, label, createdAt)
        SELECT id, duration, label, createdAt
        FROM timers
      ''');

      // Удаляем старую таблицу и переименовываем новую
      await db.execute('DROP TABLE timers');
      await db.execute('ALTER TABLE timers_new RENAME TO timers');
    }
  }

  Future<void> insertTimer(TimerModel timer) async {
    final db = await database;
    await db.insert(
      'timers',
      timer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTimer(TimerModel timer) async {
    final db = await database;
    await db.delete(
      'timers',
      where: 'id = ?',
      whereArgs: [timer.id],
    );
  }

  Future<List<TimerModel>> timersList() async {
    final db = await database;
    final List<Map<String, dynamic>> query = await db.query('timers');

    final timersList = query.map((map) => TimerModel.fromMap(map)).toList();
    for (TimerModel timer in timersList) {
      print(timer.toString());
    }
    return timersList;
  }
}
