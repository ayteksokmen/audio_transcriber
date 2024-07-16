# Audio Transcription Flutter App

This Flutter app allows users to record audio, play back the recorded audio, and receive a transcription by Whisper API
of the spoken text displayed in the UI.

## Table of Contents

- [Setup and Run the Project](#setup-and-run-the-project)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Running the App](#running-the-app)
- [App Architecture](#app-architecture)
    - [Core Layer](#core-layer)
    - [Data Layer](#data-layer)
    - [Domain Layer](#domain-layer)
    - [Presentation Layer](#presentation-layer)
- [Libraries Used](#libraries-used)

## Setup and Run the Project

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- You have installed Android Studio or Xcode (for iOS) and set up an emulator or simulator.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/ayteksokmen/audio_transcriber.git
   cd audio_transcriber

2. Install the dependencies:
   ```sh
   flutter pub get

3. Generate files (if necessary):
   If there is a compilation error, especially on transcription_service.dart file, run the following command to fix
   the issue. It will generate code based on the annotations used in transcription_service.dart file.
    ```sh
   dart run build_runner build 

### Running the App

To run the app on an emulator or physical device, use the following command:

`flutter run`

## App Architecture

The app follows a structured architecture that separates concerns into different layers: the core layer, the data layer,
the domain layer, and the presentation layer.

### Core Layer

	•	Bloc: Contains base classes for BLoC state management.
	•	Params: Contains parameter classes for various operations.
	•	Resources: Contains classes for managing data state.
	•	Utils: Contains utility classes and constants.

### Data Layer

	•	Repositories: Implements the repository interfaces defined in the domain layer.
	•	Services: Contains service classes for interacting with external APIs and functionalities.

### Domain Layer

	•	Entities: Defines the data models.
	•	Repositories: Defines repository interfaces.
	•	Use Cases: Contains use case classes for various operations.

### Presentation Layer

	•	Blocs: Contains BLoC classes for managing UI state.
	•	Screens: Contains the UI screens.
	•	Widgets: Contains reusable UI components.

## Libraries Used

The app utilizes several libraries to provide its functionality:

	•	permission_handler: Handles permission requests.
	•	record: Handles audio recording.
	•	flutter_bloc: Provides BLoC state management.
	•	retrofit: Handles HTTP requests using Retrofit.
	•	dio: HTTP client used with Retrofit.
	•	get_it: Dependency injection.
	•	fluttertoast: Displays toast messages.
	•	speech_to_text: Provides speech-to-text capabilities.
	•	audioplayers: Manages audio playback.
	•	logger: Provides logging functionalities.
	•	path_provider: Provides paths for file storage.
	•	firebase_core: Core functionalities for Firebase.
	•	wave: Displays waveform visualization.