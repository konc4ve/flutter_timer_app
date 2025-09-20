import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<Duration> settingSets = [
  Duration(minutes: 1),
  Duration(minutes: 2),
  Duration(minutes: 3),
  Duration(minutes: 4),
  Duration(minutes: 5),
  Duration(minutes: 10),
  Duration(minutes: 15),
  Duration(minutes: 20),
  Duration(minutes: 30),
  Duration(minutes: 45),
  Duration(hours: 1),
  Duration(hours: 2),
];


class SettingsSets extends StatelessWidget {
  const SettingsSets({required this.onTap, super.key});

  final void Function(Duration) onTap;

  @override
  Widget build(BuildContext context) {

    final theme = CupertinoTheme.of(context);
    return SizedBox(
      height: 60,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 15,),
        scrollDirection: Axis.horizontal,
        itemCount: settingSets.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(settingSets[index]),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 32, 32, 32),
              ),
              child: Column(
                spacing: 3,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (settingSets[index] < Duration(minutes: 59)) ...[
                    Text('${settingSets[index].inMinutes}', style: theme.textTheme.actionTextStyle.copyWith(height: 1), ),
                    Text('МИН', style: TextStyle(color: theme.primaryColor, fontSize: 14).copyWith(height: 1),),
                  ] else ...[
                    Text('${settingSets[index].inHours}', style: theme.textTheme.actionTextStyle.copyWith(height: 1),),
                    Text('Ч', style: TextStyle(color: theme.primaryColor, fontSize: 14).copyWith(height: 1),),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
