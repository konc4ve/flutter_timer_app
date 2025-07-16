class Ticker {
  const Ticker();


  Stream<Duration> tick({required Duration duration}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => Duration(seconds: duration.inSeconds - x - 1)
    ).take(duration.inSeconds);
  }
} 
