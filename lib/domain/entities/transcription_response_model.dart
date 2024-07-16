class TranscriptionResponseModel {
  final String text;

  const TranscriptionResponseModel(
      {required this.text});

  factory TranscriptionResponseModel.fromJson(Map<String, dynamic> map) {
    return TranscriptionResponseModel(
        text: map['text'] as String);
  }
}
