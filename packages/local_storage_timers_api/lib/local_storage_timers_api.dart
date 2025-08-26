import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timers_api/timers_api.dart';

class LocalStorageTimersApi implements TimersApi {
  LocalStorageTimersApi({required SharedPreferences plugin})
    : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  late final _timerStreamController = BehaviorSubject<List<Timer>>.seeded(
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
                (jsonMap) => Timer.fromJson(Map<String, dynamic>.from(jsonMap)),
              )
              .toList();
      _timerStreamController.add(todos);
    } else {
      _timerStreamController.add(const []);
    }
  }

  @override
  Stream<List<Timer>> getTimers() => _timerStreamController.asBroadcastStream();

  @override
  Future<void> saveTimer(Timer timer) {
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
