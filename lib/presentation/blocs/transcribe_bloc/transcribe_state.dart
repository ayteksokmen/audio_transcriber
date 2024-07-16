abstract class TranscribeState {
  const TranscribeState();
}

class TranscribeInitial extends TranscribeState {
  const TranscribeInitial();
}

class TranscriptionLoading extends TranscribeState {
  const TranscriptionLoading();
}

class TranscriptionSuccess extends TranscribeState {
  final String transcription;

  const TranscriptionSuccess(this.transcription);
}

class TranscriptionFailure extends TranscribeState {
  final String error;

  const TranscriptionFailure(this.error);
}
