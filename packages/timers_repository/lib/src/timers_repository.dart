import 'package:timers_api/timers_api.dart';

class TimersRepository {


  const TimersRepository({
    required TimersApi timersApi,
  }) : _timersApi = timersApi;

  final TimersApi _timersApi;

  Stream<List<Timer>> getTimers() => _timersApi.getTimers();

  Future<void> saveTimer(Timer timer) => _timersApi.saveTimer(timer);

  Future<void> deleteTimer(String id) => _timersApi.deleteTimer(id);

  void dispose() => _timersApi.close();
}