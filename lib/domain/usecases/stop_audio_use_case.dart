import '../repositories/audio_repository.dart';

class StopAudioUseCase {
  final AudioRepository repository;

  StopAudioUseCase(this.repository);

  Future<String> call() async {
    return await repository.stopPlaying();
  }
}
