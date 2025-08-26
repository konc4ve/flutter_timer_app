import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerEditPanel extends StatelessWidget {
  const TimerEditPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(color: const Color.fromARGB(255, 17, 17, 17),child: Column(children: [LabelListTile(), const Divider(height: 0, color: Color.fromARGB(255, 25, 25, 25),),EndingListTile()]));
  }
}

class LabelListTile extends StatelessWidget {
  const LabelListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
                  title: const Text(
              'Название',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            trailing: SizedBox(
              width: 290,
              child: ClearableTextField(
                controller: controller,
              ),
            ),
    );
  }
}

class EndingListTile extends StatelessWidget {
  const EndingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(title: Text('По окончании'));
  }
}
