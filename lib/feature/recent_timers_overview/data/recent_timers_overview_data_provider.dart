import 'package:flutter/cupertino.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract interface class RecentTimersOverviewDataProvider {
  Stream<List<RecentTimer>> getTimers();

  Future<void> saveTimer(RecentTimer timer);

  Future<void> deleteTimer(String id);

  Future<void> close();
}



class RecentTimersOverviewDataProviderImpl
    implements RecentTimersOverviewDataProvider {
  RecentTimersOverviewDataProviderImpl({required SharedPreferences plugin})
      : _plugin = plugin {
        _init();
      }

  final SharedPreferences _plugin;

  late final _timerStreamController = BehaviorSubject<List<RecentTimer>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kTimersCollectionKey = '__timers_collection_key__';


  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final timersJson = _getValue(kTimersCollectionKey);
    if (timersJson != null) {
      final todos =
          List<Map<dynamic, dynamic>>.from(json.decode(timersJson) as List)
              .map(
                (jsonMap) => RecentTimer.fromJson(Map<String, dynamic>.from(jsonMap)),
              )
              .toList();
      _timerStreamController.add(todos);
    } else {
      _timerStreamController.add(const []);
    }
  } 

  @override
  Stream<List<RecentTimer>> getTimers() => _timerStreamController.asBroadcastStream(); 


    @override
  Future<void> saveTimer(RecentTimer timer) {
    final timers = [..._timerStreamController.value];
    final timerIndex = timers.indexWhere((t) => t.id == timer.id);
    if (timerIndex >= 0) {
      timers[timerIndex] = timer;
    } else {
      timers.add(timer);
    }
    _timerStreamController.add(timers);
    return _setValue(kTimersCollectionKey, json.encode(timers));
  }

  @override
  Future<void> deleteTimer(String id) {
    final timers = [..._timerStreamController.value];
    final timerIndex = timers.indexWhere((t) => t.id == id);
    if (timerIndex == -1) {
      throw TimerNotFoundException();
    } else {
      timers.removeAt(timerIndex);
      _timerStreamController.add(timers);
      return _setValue(kTimersCollectionKey, jsonEncode(timers));
    }
  }

  @override
  Future<void> close() {
    return _timerStreamController.close();
  } 
}


class TimerNotFoundException implements Exception {}