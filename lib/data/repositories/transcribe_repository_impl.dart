import 'dart:convert';
import 'dart:io';

import 'package:audio_transcriber/domain/entities/transcription_response_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../core/params/transcription_request.dart';
import '../../core/resources/data_state.dart';
import '../../domain/repositories/transcribe_repository.dart';
import '../services/audio_service.dart';
import '../services/transcription_service.dart';

class TranscribeRepositoryImpl implements TranscribeRepository {
  final AudioService audioService;
  final TranscriptionService transcriptionService;

  TranscribeRepositoryImpl(this.audioService, this.transcriptionService);

  @override
  Future<DataState<TranscriptionResponseModel>> transcribe(
      String base64Audio) async {
    try {
      var request = TranscriptionRequest(base64Audio);
      final httpResponse =
          await transcriptionService.requestTranscription(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioException(
          type: DioExceptionType.receiveTimeout,
          message: httpResponse.response.statusMessage,
          requestOptions: RequestOptions(),
          response: null,
          error: httpResponse.response.statusMessage,
        ),
      );
    } on DioException catch (e) {
      Logger().e("Error by requesting transcription = $e");
      return DataFailed(e);
    }
  }
}
