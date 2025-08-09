import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';
import 'package:flutter_timer_app/feature/timer/repository/timer_manager.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/padding_wrapper.dart';
import 'package:flutter_timer_app/feature/timer/view/timer_home_page/widget/slidable_timer_list_tile/widget/timer_list_tile/timer_list_tile.dart';

class SlidableTimerListTile extends StatefulWidget {
  const SlidableTimerListTile({
    super.key,
    required this.type,
    required this.timer,
  });

  final TimerType type;
  final TimerModel timer;

  @override
  State<SlidableTimerListTile> createState() => _SlidableTimerListTileState();
}

class _SlidableTimerListTileState extends State<SlidableTimerListTile> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final timerManager = context.read<TimerManager>();

    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _color = Colors.green;
            });
          },
          icon: const Icon(Icons.change_circle),
        ),
        Container(width: 50, height: 50, color: _color),
        Expanded( // 💡 Important to avoid overflow in Row
          child: Slidable(
            key: ValueKey(widget.timer.id), // ✅ Make sure this key is stable and unique
            endActionPane: ActionPane(
              extentRatio: 0.25,
              dismissible: DismissiblePane(
                onDismissed: () {
                  if (widget.type == TimerType.active) {
                    timerManager.removeActiveTimer(widget.timer);
                  } else {
                    timerManager.removeRecentTimer(widget.timer);
                  }
                },
              ),
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  padding: EdgeInsets.zero,
                  onPressed: (_) {
                    if (widget.type == TimerType.active) {
                      timerManager.removeActiveTimer(widget.timer);
                    } else {
                      timerManager.removeRecentTimer(widget.timer);
                    }
                  },
                  label: "Удалить",
                  backgroundColor: CupertinoColors.systemRed,
                ),
              ],
            ),
            child: Column(
              children: [
                const Divider(
                  indent: 10,
                  height: 0,
                  color: Color.fromARGB(255, 21, 21, 21),
                  thickness: 0.5,
                ),
                PaddingWrapper(
    
                  child: TimerListTile(
                    timer: widget.timer,
                    type: widget.type,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class ColoredContainer extends StatefulWidget {
  const ColoredContainer({super.key});

  @override
  State<ColoredContainer> createState() => _ColoredContainerState();
}



class _ColoredContainerState extends State<ColoredContainer> {
  late Color _color;


@override
  void initState() {
    _color = Colors.red;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {
          setState(() {
            _color = Colors.green;
          });
        }, icon: Icon(Icons.change_circle)),
        Container(
          width: 50,
          height: 50,
          color: _color,
        ),
      ],
    );
  }
}