import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class SlidableWrapper extends StatelessWidget {
  const SlidableWrapper({
    required this.onPressed,
    required this.onDismissed,
    required this.widget,
    required this.valueKey,
    super.key,
  });

  final ValueKey valueKey;
  final Widget widget;
  final void Function() onDismissed;
  final void Function(BuildContext) onPressed;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: valueKey,
      endActionPane: ActionPane(
        extentRatio: 0.15,
        dismissible: DismissiblePane(onDismissed: onDismissed),
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            padding: EdgeInsets.zero,
            backgroundColor: CupertinoColors.systemRed,
            onPressed: onPressed,
            label: 'Удалить',
            flex: 1,
          ),
        ],
      ),
      child: widget,
    );
  }
}

