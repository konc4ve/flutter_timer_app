import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWrapper extends StatelessWidget {
  const SlidableWrapper(
      {
      required this.onPressed,  
      required this.onDismissed,
      required this.widget,
      required this.valueKey,
      super.key});

  final ValueKey valueKey;
  final Widget widget;
  final void Function() onDismissed;
  final void Function(BuildContext) onPressed;  
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: valueKey,
      endActionPane: ActionPane(
          dismissible: DismissiblePane(onDismissed: onDismissed),
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: CupertinoColors.systemRed,
              onPressed: onPressed,
              label: 'Удалить',
            ),
          ]),
      child: widget,
    );
  }
}
