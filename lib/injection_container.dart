import 'package:audio_transcriber/data/repositories/transcribe_repository_impl.dart';
import 'package:audio_transcriber/domain/repositories/transcribe_repository.dart';
import 'package:audio_transcriber/domain/usecases/stop_audio_use_case.dart';
import 'package:audio_transcriber/presentation/blocs/audio_bloc/audio_bloc.dart';
import 'package:audio_transcriber/presentation/blocs/transcribe_bloc/transcribe_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'data/repositories/audio_repository_impl.dart';
import 'data/services/audio_service.dart';
import 'data/services/permission_service.dart';
import 'data/services/transcription_service.dart';
import 'domain/repositories/audio_repository.dart';
import 'domain/usecases/play_audio_use_case.dart';
import 'domain/usecases/start_recording_use_case.dart';
import 'domain/usecases/stop_recording_use_case.dart';
import 'domain/usecases/transcribe_audio_use_case.dart';

final get = GetIt.instance;

void setup() {
  // Register Dio
  get.registerLazySingleton(() => Dio());

  // Register Services
  get.registerLazySingleton(() => AudioService());
  get.registerLazySingleton(() => TranscriptionService(get()));
  get.registerLazySingleton(() => PermissionService());

  // Register Repositories
  get.registerLazySingleton<AudioRepository>(() => AudioRepositoryImpl(get()));
  get.registerLazySingleton<TranscribeRepository>(
      () => TranscribeRepositoryImpl(get(), get()));

  // Register Use Cases
  get.registerLazySingleton(() => StartRecordingUseCase(get()));
  get.registerLazySingleton(() => StopRecordingUseCase(get()));
  get.registerLazySingleton(() => PlayAudioUseCase(get()));
  get.registerLazySingleton(() => StopAudioUseCase(get()));
  get.registerLazySingleton(() => TranscribeAudioUseCase(get()));

  // Register Blocs
  get.registerFactory(() => AudioBloc(get(), get(), get(), get()));
  get.registerFactory(() => TranscribeBloc(get()));
}
