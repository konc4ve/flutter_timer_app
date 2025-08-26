import 'package:flutter_timer_app/feature/recent_timers_overview/data/recent_timers_overview_data_provider.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/models/models.dart';

abstract interface class RecentTimersOverviewRepository {

  Stream<List<RecentTimer>> getRecentTimers();

  Future<void> saveRecentTimer(RecentTimer timer);

  Future<void> deleteRecentTimer(String id);

  void dispose();
} 

class RecentTimersOverviewRepositoryImpl implements RecentTimersOverviewRepository {
  RecentTimersOverviewRepositoryImpl(
    RecentTimersOverviewDataProvider recentTimersOverviewDataProvider
  ) : _recentTimersOverviewDataProvider = recentTimersOverviewDataProvider;

  final RecentTimersOverviewDataProvider _recentTimersOverviewDataProvider;

  @override
  Stream<List<RecentTimer>> getRecentTimers() => _recentTimersOverviewDataProvider.getTimers();
  
  @override
  Future<void> saveRecentTimer(RecentTimer timer) => _recentTimersOverviewDataProvider.saveTimer(timer);

  @override
  Future<void> deleteRecentTimer(String id) => _recentTimersOverviewDataProvider.deleteTimer(id);

  @override
  void dispose() => _recentTimersOverviewDataProvider.close();

}