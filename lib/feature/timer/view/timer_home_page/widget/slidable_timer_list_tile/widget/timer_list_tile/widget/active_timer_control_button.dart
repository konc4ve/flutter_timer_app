import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ActiveTimerControlType { pause, run }



class ActiveTimerControlButton extends StatefulWidget {
  final Duration duration;
  final ActiveTimerControlType controlType;
  final VoidCallback onTap;

  const ActiveTimerControlButton({
    required this.duration,
    required this.controlType,
    required this.onTap,
    super.key,
  });

  @override
  State<ActiveTimerControlButton> createState() => _ActiveTimerControlButtonState();
}

class _ActiveTimerControlButtonState extends State<ActiveTimerControlButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Автостарт, если тип "run"
    if (widget.controlType == ActiveTimerControlType.pause) {
      _controller.forward(from: 0);
    }
  }

  @override
  void didUpdateWidget(covariant ActiveTimerControlButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Если изменился режим или duration — переинициализируем
    if (oldWidget.controlType != widget.controlType ||
        oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;

      if (widget.controlType == ActiveTimerControlType.run) {
        if (!_controller.isAnimating) {
          _controller.stop();
        }
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap();

    if (widget.controlType == ActiveTimerControlType.run) {
      _controller.forward();
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: GestureDetector(
        onTap: _handleTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CircularProgressIndicator(
                    value: 1 - _controller.value,
                    color: CupertinoColors.activeOrange,
                  );
                },
              ),
            ),
            widget.controlType == ActiveTimerControlType.run
                ? Transform.translate(
                    offset: Offset(1, 0),
                    child: Icon(
                      CupertinoIcons.play_arrow_solid,
                      color: CupertinoColors.activeOrange,
                    ),
                  )
                : const Icon(
                    CupertinoIcons.pause_fill,
                    color: CupertinoColors.activeOrange,
                  )
          ],
        ),
      ),
    );
  }
}