
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_app/timers/services/alarm_player.dart';
import 'package:flutter_timer_app/timers/feature/active_timers_overview/models/active_timer_entity.dart';
import 'package:flutter_timer_app/timers/feature/edit_timer/bloc/edit_timer_bloc.dart';
import 'package:get_it/get_it.dart';

class EditMelodyModalSheet extends StatefulWidget {
  const EditMelodyModalSheet({super.key});

  @override
  State<EditMelodyModalSheet> createState() => _EditMelodyModalSheetState();
}

class _EditMelodyModalSheetState extends State<EditMelodyModalSheet> {
  late final EditTimerBloc _editTimerBloc;
  late final AlarmPlayer _player;
  AlarmMelody? selectedMelody;
  bool isPlaying = false;

  @override
  void initState() {
    _editTimerBloc = context.read<EditTimerBloc>();
    _player = GetIt.I<AlarmPlayer>();
    super.initState();
  }

  @override
  void dispose() {
    _player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final melodies = AlarmMelody.values;
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      navigationBar: CupertinoNavigationBar(
        trailing: TextButton(
          onPressed: () async {
            _editTimerBloc.add(
              EditTimerMelodyChanged(
                selectedMelody ?? _editTimerBloc.state.melody,
              ),
            );
            Navigator.pop(context);
            await _player.stop();
          },
          child: Text('Установить'),
        ),
        padding: EdgeInsetsDirectional.zero,
        leading: Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                Navigator.pop(context);
                await _player.stop();
              },
              icon: Icon(CupertinoIcons.back),
            ),
            Text('По окончании'),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                margin: EdgeInsets.zero,
                color: const Color.fromARGB(255, 33, 33, 33),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: melodies.length,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsetsGeometry.only(left: 40),
                    child: Divider(
                      height: 0,
                      color: const Color.fromARGB(255, 55, 55, 55),
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final melody = melodies[index];
                    final isSelected = melody == selectedMelody;
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CupertinoListTile(
                        backgroundColorActivated: Colors.transparent,
                        padding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            if (isSelected)
                              const Icon(CupertinoIcons.check_mark, size: 20)
                            else
                              const SizedBox(width: 20),
                            const SizedBox(
                              width: 10,
                            ), // небольшой отступ между иконкой и текстом
                            Text(
                              melody.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onTap: () async {
                          if (isPlaying && selectedMelody == melody) {
                            // Если эта мелодия уже играет → останавливаем
                            await _player.stop();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            // Если другая мелодия или ничего не играет → запускаем
                            await _player
                                .stop(); // на всякий случай остановим предыдущую
                            await _player.play(melody.filename);
                            setState(() {
                              selectedMelody = melody;
                              isPlaying = true;
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
