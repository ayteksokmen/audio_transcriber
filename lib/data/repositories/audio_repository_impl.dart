import '../../domain/repositories/audio_repository.dart';
import '../services/audio_service.dart';
import '../services/transcription_service.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioService audioService;

  AudioRepositoryImpl(this.audioService);

  @override
  Future<void> startRecording() async {
    await audioService.startRecording();
  }

  @override
  Future<String> stopRecording() async {
    return await audioService.stopRecording();
  }

  @override
  Future<void> playRecording() async {
    await audioService.playRecording();
  }

  @override
  Future<String> stopPlaying() async {
    return await audioService.stopPlaying();
  }
}
