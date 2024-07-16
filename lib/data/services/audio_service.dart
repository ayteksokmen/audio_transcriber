import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../core/utils/constants.dart';

class AudioService {
  var _player = AudioPlayer();
  final _record = AudioRecorder();
  String? _filePath;

  Future<void> startRecording() async {
    if (await _record.hasPermission()) {
      final dir = await getTemporaryDirectory();
      _filePath = File('${dir.path}/$kAudioRecordFileName').path;
      await _record.start(const RecordConfig(), path: _filePath!);
    } else {
      throw Exception('Microphone permission not granted');
    }
  }

  Future<String> stopRecording() async {
    await _record.stop();
    return _filePath!;
  }

  Future<void> playRecording() async {
    if (_filePath == null) {
      throw Exception('No recording found to play');
    }

    var source = DeviceFileSource(_filePath!);
    _player = AudioPlayer();
    await _player.play(source);
  }

  Future<String> stopPlaying() async {
    await _player.stop();
    return _filePath!;
  }
}
