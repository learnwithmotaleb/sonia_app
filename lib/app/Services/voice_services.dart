import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  VoiceService() {
    _speech = stt.SpeechToText();
  }

  Future<void> initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );
    if (available) {
      print('Speech recognition ready');
    }
  }

  void startListening() {
    _speech.listen(
      onResult: (result) {
        _text = result.recognizedWords;
        print('You said: $_text');
        // You can add custom command detection here:
        if (_text.toLowerCase().contains("find my phone")) {
          // trigger your find phone logic
        }
      },
    );
    _isListening = true;
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;
  }
}
