abstract class TranscribeEvent {}

class ResetTranscribe extends TranscribeEvent {}

class TranscribeLoading extends TranscribeEvent {}

class TranscribeAudio extends TranscribeEvent {
  final String filePath;

  TranscribeAudio(this.filePath);
}