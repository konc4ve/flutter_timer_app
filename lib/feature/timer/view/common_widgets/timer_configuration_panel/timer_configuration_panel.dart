import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/view/common_widgets/timer_configuration_panel/widget/clearable_textfield.dart';

class TimerConfigurationPanel extends StatelessWidget {
  final TextEditingController controller;

  const TimerConfigurationPanel({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 17, 17, 17),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
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
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text(
              'По окончании',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Радиус',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: const Color.fromARGB(255, 167, 165, 165)),
                ),
                SizedBox(width: 18, child: Icon(Icons.chevron_right)),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
