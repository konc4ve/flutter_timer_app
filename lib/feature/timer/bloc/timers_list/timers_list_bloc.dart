import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/timer/db/timer_database.dart';
import 'package:flutter_timer_app/feature/timer/di/service_locator.dart';
import 'package:flutter_timer_app/feature/timer/model/timer_model.dart';


part 'timers_list_event.dart';
part 'timers_list_state.dart';

class TimersListBloc extends Bloc<TimersListEvent, TimersListState> {
  final TimerDatabase _db = getIt<TimerDatabase>();
  TimersListBloc() : super(TimersListInitial()) {

    on<LoadTimersList>((LoadTimersList event, emit) async{
      emit(LoadTimersListInProgress());
      try {
        final timersList = await _db.timersList();
        emit(LoadTimersListSuccess(timersList: timersList));
      } catch (e) {
        emit(LoadTimersListFailure(error: e.toString()));
      }
    });
    on<AddTimer>(_onAddTimer);
  }

  void _onAddTimer(AddTimer event, Emitter<TimersListState> emit) async {
  emit(AddTimerInProgress());
  try {
    final newTimer = TimerModel(
      duration: event.duration, 
      createdAt: DateTime.now(),
    );
    await _db.insertTimer(newTimer);
    if (state is LoadTimersListSuccess) {
      final currentState = state as LoadTimersListSuccess;
      final updatedList = List<TimerModel>.from(currentState.timersList)..add(newTimer);
      emit(LoadTimersListSuccess(timersList: updatedList));
    } else {
      add(LoadTimersList());
    }
    emit(AddTimerSuccess());
  } catch (e) {
    emit(AddTimerFailure(error: e.toString()));
  }
}

}
