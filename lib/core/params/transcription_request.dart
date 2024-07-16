import 'dart:convert';

class TranscriptionRequest {
  final String base64Audio;

  TranscriptionRequest(this.base64Audio);

  factory TranscriptionRequest.fromJson(Map<String, dynamic> json) =>
      jsonDecode(json as String);

  Map<String, dynamic> toJson() {
    return {'audioFile': base64Audio};
  }
}
