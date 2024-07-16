import 'package:audio_transcriber/domain/usecases/stop_audio_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/play_audio_use_case.dart';
import '../../../domain/usecases/start_recording_use_case.dart';
import '../../../domain/usecases/stop_recording_use_case.dart';
import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;
  final PlayAudioUseCase playAudioUseCase;
  final StopAudioUseCase stopAudioUseCase;

  AudioBloc(
    this.startRecordingUseCase,
    this.stopRecordingUseCase,
    this.playAudioUseCase,
    this.stopAudioUseCase,
  ) : super(const AudioInitial()) {
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<PlayRecording>(_onPlayRecording);
    on<StopPlaying>(_onStopPlaying);
  }

  void _onStartRecording(StartRecording event, Emitter<AudioState> emit) async {
    await startRecordingUseCase.call();
    emit(RecordingInProgress());
  }

  void _onStopRecording(StopRecording event, Emitter<AudioState> emit) async {
    final filePath = await stopRecordingUseCase.call();
    emit(RecordingStopped(filePath));
  }

  void _onPlayRecording(PlayRecording event, Emitter<AudioState> emit) async {
    await playAudioUseCase.call();
    emit(PlayingAudio());
  }

  void _onStopPlaying(StopPlaying event, Emitter<AudioState> emit) async {
    await stopAudioUseCase.call();
    emit(AudioStopped());
  }
}
