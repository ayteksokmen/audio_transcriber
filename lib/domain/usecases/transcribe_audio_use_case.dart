import 'dart:convert';
import 'dart:io';

import 'package:audio_transcriber/core/resources/data_state.dart';

import 'package:audio_transcriber/domain/entities/transcription_response_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/utils/constants.dart';
import '../repositories/transcribe_repository.dart';

class TranscribeAudioUseCase {
  final TranscribeRepository repository;

  TranscribeAudioUseCase(this.repository);

  Future<DataState<TranscriptionResponseModel>> call() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$kAudioRecordFileName');

    List<int> audioBytes = file.readAsBytesSync();
    String base64Audio = base64Encode(audioBytes);

    return await repository.transcribe(base64Audio);
  }
}
