import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerController {
  TimerController({required StopWatchTimer stopWatchTimer})
    : _stopWatchTimer = stopWatchTimer;

  final StopWatchTimer _stopWatchTimer;

  
  Stream<int> get time => _stopWatchTimer.secondTime;

  void start() => _stopWatchTimer.onStartTimer();

  void pause() => _stopWatchTimer.onStopTimer();

  Future<void> dispose() async {
    await _stopWatchTimer.dispose();
  }
}
