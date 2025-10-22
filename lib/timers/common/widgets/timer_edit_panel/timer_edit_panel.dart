import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/common/widgets/timer_edit_panel/clearable_textfield.dart';
import 'package:flutter_timer_app/timers/common/widgets/timer_edit_panel/edit_melody_modal_sheet.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/bloc/edit_timer_bloc.dart';


class TimerEditPanel extends StatelessWidget {
  const TimerEditPanel({
    required EditTimerBloc editTimerBloc,
    required this.controller,
    super.key,
  }) : _editTimerBloc = editTimerBloc;
  final TextEditingController controller;
  final EditTimerBloc _editTimerBloc;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: Card(
        margin: EdgeInsets.zero,
        color: const Color.fromARGB(255, 17, 17, 17),
        child: Column(
          children: [
            LabelListTile(controller: controller),
            const Divider(height: 0, color: Color.fromARGB(255, 25, 25, 25)),
            EndingListTile(editTimerBloc: _editTimerBloc),
          ],
        ),
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
        width: 50,
        child: ClearableTextField(controller: controller),
      ),
    );
  }
}

class EndingListTile extends StatelessWidget {
  const EndingListTile({required EditTimerBloc editTimerBloc, super.key})
    : _editTimerBloc = editTimerBloc;
  final EditTimerBloc _editTimerBloc;
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
          BlocBuilder<EditTimerBloc, EditTimerState>(
            builder: (context, state) {
              return Text(
                state.melody.name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color.fromARGB(255, 167, 165, 165),
                ),
              );
            },
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
      onTap: () {
        showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context,
          builder: (context) => BlocProvider.value(
            value: _editTimerBloc,
            child: EditMelodyModalSheet(),
          ),
        );
      },
    );
  }
}
