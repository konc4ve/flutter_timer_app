import 'package:flutter/material.dart';
import 'package:flutter_timer_app/bootstrap.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';

import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final recentTimersOverviewDataProviderImpl =
      RecentTimersOverviewDataProviderImpl(
        plugin: await SharedPreferences.getInstance(),
      );
  final activeTimersOverviewDataProviderImpl =
      ActiveTimersOverviewDataProviderImpl();



  bootstrap(
    recentTimersOverviewDataProviderImp: recentTimersOverviewDataProviderImpl,
    activeTimersOverviewDataProviderImpl: activeTimersOverviewDataProviderImpl,
  );

  

}
