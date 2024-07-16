import '../repositories/audio_repository.dart';

class StopRecordingUseCase {
  final AudioRepository repository;

  StopRecordingUseCase(this.repository);

  Future<String> call() async {
    return await repository.stopRecording();
  }
}
