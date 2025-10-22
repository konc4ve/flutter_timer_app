import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/active_timers_overview.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/models/edit_timer.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/data/recent_timers_overview_repository.dart';
import 'package:flutter_timer_app/timers/feature/recent_timers_overview/models/recent_timer_entity.dart';

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
           status: EditTimerStatus.initial,
           initialTimer: initialTimer,
           duration: initialTimer?.duration ?? Duration.zero,
           label: initialTimer?.label ?? '',
         ),
       ) {
    on<EditTimerDurationChanged>(_onDurationChanged);
    on<EditTimerLabelChanged>(_onLabelChanged);
    on<EditTimerSubmitted>(_onSubmitted);
    on<EditTimerReset>(_onReset);
    on<EditTimerMelodyChanged>(_onMelodyChanged);
  }

  final RecentTimersOverviewRepository _recentTimersOverviewRepository;
  final ActiveTimersOverviewRepository _activeTimersOverviewRepository;

  void _onDurationChanged(
    EditTimerDurationChanged event,
    Emitter<EditTimerState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onMelodyChanged(
    EditTimerMelodyChanged event,
    Emitter<EditTimerState> emit,
  ) {
    emit(state.copyWith(melody: event.melody));
  }

  void _onLabelChanged(
    EditTimerLabelChanged event,
    Emitter<EditTimerState> emit,
  ) {
    emit(state.copyWith(label: event.label));
  }

  void _onReset(EditTimerReset event, Emitter<EditTimerState> emit) {
    emit(
      state.copyWith(
        duration: Duration.zero,
        label: '',
        melody: AlarmMelody.defaultMelody,
      ),
    );
  }

  Future<void> _onSubmitted(
    EditTimerSubmitted event,
    Emitter<EditTimerState> emit,
  ) async {
    emit(state.copyWith(status: EditTimerStatus.loading));

    try {
      if (state.initialTimer != null) {
        // Редактируем существующий активный таймер: только label
        final currentTimers = await _activeTimersOverviewRepository
            .watchTimers()
            .first;
        final currentTimer = currentTimers.firstWhere(
          (t) => t.id == state.initialTimer!.id,
        );

        final updatedTimer = currentTimer.copyWith(
          label: state.label,
          alarmMelody: state.melody,
        );

        await _activeTimersOverviewRepository.upDateActiveTimer(updatedTimer);
      } else {
        // Создаём новый таймер
        final newTimer = EditTimer(
          alarmMelody: state.melody,
          duration: state.duration,
          label: state.label,
        );

        final recentTimers = await _recentTimersOverviewRepository
            .watchTimers()
            .first;
        final isDuplicate = recentTimers.any(
          (t) =>
              t.setDuration == newTimer.duration && t.label == newTimer.label,
        );

        if (isDuplicate) {
          await _activeTimersOverviewRepository.saveActiveTimer(
            ActiveTimerEntity.fromEdit(newTimer),
          );
          emit(state.copyWith(status: EditTimerStatus.duplicate));
          return;
        }

        // Сохраняем новый таймер в недавние и активные
        await _recentTimersOverviewRepository.saveRecentTimer(
          RecentTimerEntity.fromEdit(newTimer),
        );
        await _activeTimersOverviewRepository.saveActiveTimer(
          ActiveTimerEntity.fromEdit(newTimer),
        );
      }

      emit(state.copyWith(status: EditTimerStatus.success));
      add(EditTimerReset());
    } catch (e, st) {
      debugPrint('EditTimerBloc error: $e\n$st');
      emit(state.copyWith(status: EditTimerStatus.failure));
    }
  }
}
