abstract class AudioRepository {
  Future<void> startRecording();

  Future<String> stopRecording();

  Future<void> playRecording();

  Future<String> stopPlaying();
}
