import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_app/common/widgets/timer_edit_panel/clearable_textfield.dart';

class TimerEditPanel extends StatelessWidget {
  const TimerEditPanel({required this.controller, super.key});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: const Color.fromARGB(255, 17, 17, 17),
      child: Column(
        children: [
          LabelListTile(controller: controller),
          const Divider(height: 0, color: Color.fromARGB(255, 25, 25, 25)),
          EndingListTile(),
        ],
      ),
    );
  }
}

class LabelListTile extends StatelessWidget {
  const LabelListTile({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: const Text(
        'Название',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      trailing: SizedBox(
        width: 290,
        child: ClearableTextField(controller: controller),
      ),
    );
  }
}

class EndingListTile extends StatelessWidget {
  const EndingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: const Text(
        'По окончании',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Радиус',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color.fromARGB(255, 167, 165, 165),
            ),
          ),
          SizedBox(
            width: 18,
            child: Icon(
              Icons.chevron_right,
              color: const Color.fromARGB(255, 61, 61, 61),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
