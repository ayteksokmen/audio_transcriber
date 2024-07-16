import 'dart:io';

import '../../core/resources/data_state.dart';
import '../entities/transcription_response_model.dart';

abstract class TranscribeRepository {
  Future<DataState<TranscriptionResponseModel>> transcribe(String base64Audio);
}
