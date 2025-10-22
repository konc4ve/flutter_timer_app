import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_app/timers/common/common.dart';

class ClocksOverviewScreen extends StatelessWidget {
  const ClocksOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: CupertinoColors.black,
            largeTitle: Text('Мировые часы'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  if (index == 0)
                    Column(children: [Divider(), ClockListTile(), Divider()]),
                  Column(children: [ClockListTile(), Divider()]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClockListTile extends StatelessWidget {
  const ClockListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Column(children: [Text('Сегодня, +0 Ч'), Text('Москва')]),
      trailing: Text('16:50', style: TextStyle(fontSize: 40)),
    );
  }
}
