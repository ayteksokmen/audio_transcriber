import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/transcribe_audio_use_case.dart';
import 'transcribe_event.dart';
import 'transcribe_state.dart';

class TranscribeBloc extends Bloc<TranscribeEvent, TranscribeState> {
  final TranscribeAudioUseCase transcribeAudioUseCase;

  TranscribeBloc(
    this.transcribeAudioUseCase,
  ) : super(const TranscribeInitial()) {
    on<TranscribeAudio>(_onTranscribeAudio);
    on<ResetTranscribe>(_onResetTranscribe);
  }

  void _onTranscribeAudio(
      TranscribeAudio event, Emitter<TranscribeState> emit) async {
    try {
      emit(const TranscriptionLoading());
      final transcriptionResponse = await transcribeAudioUseCase.call();
      var transcriptionResponseData = transcriptionResponse.data;
      var transcription = transcriptionResponseData?.text ?? "";
      emit(TranscriptionSuccess(transcription));
    } catch (e) {
      emit(TranscriptionFailure(e.toString()));
    }
  }

  void _onResetTranscribe(
      ResetTranscribe event, Emitter<TranscribeState> emit) {
    emit(const TranscribeInitial());
  }
}
