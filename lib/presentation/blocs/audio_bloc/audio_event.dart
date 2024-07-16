abstract class AudioEvent {}

class StartRecording extends AudioEvent {}

class StopRecording extends AudioEvent {}

class PlayRecording extends AudioEvent {}

class StopPlaying extends AudioEvent {}