import 'dart:async';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../core/params/transcription_request.dart';
import '../../core/utils/constants.dart';
import '../../domain/entities/transcription_response_model.dart';

part 'transcription_service.g.dart';

@RestApi(baseUrl: kWhisperApiUrl)
abstract class TranscriptionService {
  factory TranscriptionService(Dio dio, {String baseUrl}) =
      _TranscriptionService;

  @Headers({'Content-type': 'application/json'})
  @POST("/whisperTranscription")
  Future<HttpResponse<TranscriptionResponseModel>> requestTranscription(
      @Body() TranscriptionRequest request);
}
