import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_app/timers/screens/timers_overview_screen.dart';
import 'package:flutter_timer_app/world_clock/screens/clocks_overview_screen.dart';

class TabScaffold extends StatelessWidget {
  const TabScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.timer),
            label: 'Таймеры',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock_fill),
            label: 'Мировые часы',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => TimersOverviewScreen(),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => ClocksOverviewScreen(),
            );
          default:
            return CupertinoTabView(
              builder: (context) => TimersOverviewScreen(),
            );
        }
      },
    );
  }
}
