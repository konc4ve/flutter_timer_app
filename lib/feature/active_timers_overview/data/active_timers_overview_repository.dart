import 'package:flutter_timer_app/feature/active_timers_overview/data/active_timers_overview_data_provider.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/models/models.dart';

abstract interface class ActiveTimersOverviewRepository {
  Stream<List<ActiveTimer>> getActiveTimers();

  Future<void> saveActiveTimer(ActiveTimer timer);

  Future<void> deleteActiveTimer(String id);

  Future<void> dispose();
}

class ActiveTimersOverviewRepositoryImpl
    implements ActiveTimersOverviewRepository {
  ActiveTimersOverviewRepositoryImpl(
      ActiveTimersOverviewDataProvider dataProvider)
      : _activeTimersOverviewDataProvider = dataProvider;

  final ActiveTimersOverviewDataProvider _activeTimersOverviewDataProvider;

  @override
  Stream<List<ActiveTimer>> getActiveTimers() =>
      _activeTimersOverviewDataProvider.getActiveTimers();

  @override
  Future<void> saveActiveTimer(ActiveTimer timer) =>
      _activeTimersOverviewDataProvider.saveActiveTimer(timer);

  @override
  Future<void> deleteActiveTimer(String id) =>
      _activeTimersOverviewDataProvider.deleteActiveTimer(id);

  @override
  Future<void> dispose() => _activeTimersOverviewDataProvider.close();
  
}

class ActiveTimerNotFoundException implements Exception {}
