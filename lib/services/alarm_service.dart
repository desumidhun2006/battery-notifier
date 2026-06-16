import 'package:just_audio/just_audio.dart';

class AlarmService {
  AudioPlayer? _player;
  String? _customPath;

  void setCustomPath(String? path) {
    _customPath = path;
  }

  Future<void> play() async {
    await stop();
    _player = AudioPlayer();
    try {
      if (_customPath != null) {
        await _player!.setFilePath(_customPath!);
      } else {
        await _player!.setAsset('assets/alarm.wav');
      }
      await _player!.setLoopMode(LoopMode.one);
      await _player!.play();
    } catch (e) {
      await stop();
    }
  }

  Future<void> stop() async {
    if (_player != null) {
      await _player!.stop();
      await _player!.dispose();
      _player = null;
    }
  }

  bool get isPlaying => _player?.playing ?? false;
}
