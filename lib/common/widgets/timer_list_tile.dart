import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_timer_app/common/formated_label.dart';

class TimerListTile extends StatelessWidget {
  const TimerListTile({
    this.onTap,
    required this.label,
    required this.duration,
    required this.title,
    required this.trailing,
    super.key,
  });

  final Widget title;

  final String label;

  final VoidCallback? onTap;

  final Duration duration;

  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoListTile(
        onTap: onTap,
        padding: EdgeInsets.zero,
        title: title,
        subtitle: (label == '')
            ? Text(formatLabelFromDuration(duration))
            : Text(label),
        trailing: AnimatedBuilder(
          animation: Slidable.of(context)!.animation,
          builder: (context, child) {
            final progress = Slidable.of(context)!.animation.value;
            return (progress > 0.0) ? SizedBox() : child!;
          },
          child: trailing,
        ),
      ),
    );
  }
}
