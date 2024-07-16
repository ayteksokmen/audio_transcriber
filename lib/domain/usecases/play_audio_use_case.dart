import '../repositories/audio_repository.dart';

class PlayAudioUseCase {
  final AudioRepository repository;

  PlayAudioUseCase(this.repository);

  Future<void> call() async {
    return await repository.playRecording();
  }
}
