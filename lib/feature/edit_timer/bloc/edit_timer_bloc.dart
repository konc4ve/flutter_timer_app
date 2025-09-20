import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer_app/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/feature/edit_timer/models/edit_timer.dart';
import 'package:flutter_timer_app/feature/recent_timers_overview/recent_timers_overview.dart';

part 'edit_timer_event.dart';
part 'edit_timer_state.dart';

class EditTimerBloc extends Bloc<EditTimerEvent, EditTimerState> {
  EditTimerBloc({
    required ActiveTimersOverviewRepository activeTimersOverviewRepository,
    required RecentTimersOverviewRepository recentTimersOverviewRepository,
    required EditTimer? initialTimer,
  }) : _recentTimersOverviewRepository = recentTimersOverviewRepository,
       _activeTimersOverviewRepository = activeTimersOverviewRepository,
       super(
         EditTimerState(
           initialTimer: initialTimer,
           duration: initialTimer?.duration ?? Duration.zero,
           label: initialTimer?.label ?? '',
         ),
       ) {
    on<EditTimerDurationChanged>(_onDurationChanged);
    on<EditTimerLabelChanged>(_onLabelChanged);
    on<EditTimerSubmitted>(_onSubmitted);
    on<EditTimerReset>(_onReset);
  }

  final RecentTimersOverviewRepository _recentTimersOverviewRepository;

  final ActiveTimersOverviewRepository _activeTimersOverviewRepository;

  void _onDurationChanged(
    EditTimerDurationChanged event,
    Emitter<EditTimerState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onReset(EditTimerReset event, Emitter<EditTimerState> emit) {
    emit(state.copyWith(duration: Duration.zero, label: ''));
  }

  void _onLabelChanged(
    EditTimerLabelChanged event,
    Emitter<EditTimerState> emit,
  ) {
    emit(state.copyWith(label: event.label));
  }

  Future<void> _onSubmitted(
    EditTimerSubmitted event,
    Emitter<EditTimerState> emit,
  ) async {
    emit(state.copyWith(status: EditTimerStatus.loading));

    try {
      if (state.initialTimer != null) {
        final updatedTimer = state.initialTimer!.copyWith(
          duration: state.duration,
          label: state.label,
        );
        await _activeTimersOverviewRepository.upDateActiveTimer(
          ActiveTimer.fromEdit(updatedTimer),
        );
      } else {
        final timer = EditTimer(duration: state.duration, label: state.label);
        final recentTimers = await _recentTimersOverviewRepository
            .getRecentTimers()
            .first;

        final isDuplicate = recentTimers.any(
          (t) => t.duration == timer.duration && t.label == timer.label,
        );

        if (isDuplicate) {
          emit(state.copyWith(status: EditTimerStatus.duplicate));
          return;
        }
        await _recentTimersOverviewRepository.saveRecentTimer(
          RecentTimer.fromEdit(timer),
        );
        await _activeTimersOverviewRepository.saveActiveTimer(
          ActiveTimer.fromEdit(timer),
        );
      }

      emit(state.copyWith(status: EditTimerStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTimerStatus.failture));
    }
  }
}
