import 'package:audioplayers/audioplayers.dart';

class AlarmPlayer {
  AlarmPlayer({required AudioPlayer player}) : _player = player;

  final AudioPlayer _player;

  Future<void> play(String filename) async {
    await _player.play(AssetSource('mp3s/$filename'));
  }

  Future<void> stop() async {
    await _player.stop();
  }
}
