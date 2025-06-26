import 'package:flutter/material.dart';
import 'package:flutter_timer_app/feature/timer/view/widget/timer_configuration_panel/widget/clearable_textfield.dart';

class TimerConfigurationPanel extends StatelessWidget {
  final TextEditingController controller;
  
  const TimerConfigurationPanel({
    required this.controller,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Название'),
            trailing:  SizedBox(
              child: ClearableTextField(controller: controller,),
            ),
          ),
          const Divider(height: 1, thickness: 0.5,),
          ListTile(
            title: const Text('По окончании'),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Радиус'), 
                Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

