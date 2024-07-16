import 'package:audio_transcriber/presentation/widgets/home_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../blocs/audio_bloc/audio_bloc.dart';
import '../blocs/audio_bloc/audio_event.dart';
import '../blocs/audio_bloc/audio_state.dart';
import '../blocs/transcribe_bloc/transcribe_bloc.dart';
import '../blocs/transcribe_bloc/transcribe_event.dart';
import '../blocs/transcribe_bloc/transcribe_state.dart';

enum WaveAnimationState {
  recording,
  playing;

  String getTitle() {
    switch (this) {
      case WaveAnimationState.recording:
        return "Recording..";
      case WaveAnimationState.playing:
        return "Playing..";
    }
  }

  List<List<Color>> getGradients() {
    switch (this) {
      case WaveAnimationState.recording:
        return [
          [Colors.redAccent, Colors.pinkAccent],
          [Colors.pink, Colors.red],
        ];
      case WaveAnimationState.playing:
        return [
          [Colors.lightBlue, Colors.blue],
          [Colors.blue, Colors.lightBlueAccent],
        ];
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<AudioBloc, AudioState>(
            builder: (context, state) {
              switch (state) {
                case RecordingInProgress():
                  return buildRecordInProgressStateUI(context);
                case RecordingStopped():
                  context
                      .read<TranscribeBloc>()
                      .add(TranscribeAudio(state.filePath));
                  return buildStopStateUI(context);
                case AudioStopped():
                  return buildStopStateUI(context);
                case PlayingAudio():
                  return buildPlayingAudioStateUI(context);
                default:
                  return buildDefaultUI(context);
              }
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<TranscribeBloc, TranscribeState>(
                builder: (context, state) {
                  if (state is TranscriptionSuccess) {
                    return buildTranscribedStateUI(context, state);
                  } else if (state is TranscriptionFailure) {
                    return Text('Error: ${state.error}');
                  } else if (state is TranscriptionLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildTranscribedStateUI(
      BuildContext context, TranscriptionSuccess state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          children: [
            Icon(Icons.transcribe, size: 20),
            SizedBox(
              width: 8,
            ),
            Text('Transcription', style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.15,
          child: Text(
            state.transcription,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildDefaultUI(BuildContext context) {
    return HomeButton(
      text: 'Start Recording',
      onPressed: () async {
        context.read<AudioBloc>().add(StartRecording());
      },
      icon: Icons.fiber_manual_record,
      iconColor: Colors.red,
    );
  }

  Widget buildRecordInProgressStateUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildWaveAnimation(WaveAnimationState.recording),
        const SizedBox(
          height: 40,
        ),
        HomeButton(
          text: 'Stop & Transcribe',
          onPressed: () async {
            context.read<AudioBloc>().add(StopRecording());
          },
          icon: Icons.stop_circle,
          iconColor: Colors.red,
        ),
      ],
    );
  }

  Column buildWaveAnimation(WaveAnimationState waveAnimationState) {
    return Column(
      children: [
        Text(
          waveAnimationState.getTitle(),
          style: const TextStyle(fontSize: 24),
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: WaveWidget(
              config: CustomConfig(
                gradients: waveAnimationState.getGradients(),
                durations: [3500, 1944],
                heightPercentages: [0.20, 0.23],
              ),
              size: const Size(double.infinity, 100.0),
            )),
      ],
    );
  }

  Column buildPlayingAudioStateUI(BuildContext context) {
    return Column(
      children: [
        buildWaveAnimation(WaveAnimationState.playing),
        const SizedBox(
          height: 40,
        ),
        HomeButton(
          text: 'Stop Playing',
          onPressed: () async {
            context.read<AudioBloc>().add(StopPlaying());
          },
          icon: Icons.stop_circle,
          iconColor: Colors.blue,
        ),
      ],
    );
  }

  Column buildStopStateUI(BuildContext context) {
    return Column(
      children: [
        HomeButton(
          text: 'Play Recording',
          onPressed: () async {
            context.read<AudioBloc>().add(PlayRecording());
          },
          icon: Icons.play_circle,
          iconColor: Colors.blue,
        ),
        const SizedBox(height: 20),
        HomeButton(
          text: 'Restart Recording',
          onPressed: () async {
            context.read<AudioBloc>().add(StartRecording());
            context.read<TranscribeBloc>().add(ResetTranscribe());
          },
          icon: Icons.restart_alt,
          iconColor: Colors.red,
        )
      ],
    );
  }
}
