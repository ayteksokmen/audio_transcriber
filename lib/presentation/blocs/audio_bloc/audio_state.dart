abstract class AudioState {
  const AudioState();
}

class AudioInitial extends AudioState {
  const AudioInitial();
}

class RecordingInProgress extends AudioState {}

class RecordingStopped extends AudioState {
  final String filePath;

  RecordingStopped(this.filePath);
}

class PlayingAudio extends AudioState {}

class AudioStopped extends AudioState {}

class AudioTranscription extends AudioState {
  final String transcription;

  const AudioTranscription(this.transcription);
}

class AudioError extends AudioState {
  final String error;

  const AudioError(this.error);
}
