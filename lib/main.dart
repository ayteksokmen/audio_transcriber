import 'package:audio_transcriber/presentation/blocs/transcribe_bloc/transcribe_bloc.dart';
import 'package:audio_transcriber/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_transcriber/injection_container.dart' as injector;
import 'package:audio_transcriber/presentation/blocs/audio_bloc/audio_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  injector.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioBloc>(
          create: (_) => injector.get<AudioBloc>(),
        ),
        BlocProvider<TranscribeBloc>(
          create: (_) => injector.get<TranscribeBloc>(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Audio Transcription App')),
          body: HomeScreen(),
        ),
      ),
    );
  }
}
