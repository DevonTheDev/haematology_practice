import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// Main function only used for testing
void main() {
  runApp(SpeechRecognitionReading());
}

class SpeechRecognitionReading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text Demo',
      home: SpeechToTextDemo(),
    );
  }
}

class SpeechToTextDemo extends StatefulWidget {
  @override
  _SpeechToTextDemoState createState() => _SpeechToTextDemoState();
}

class _SpeechToTextDemoState extends State<SpeechToTextDemo> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Wrap the Text widget with SingleChildScrollView for scrolling
            SingleChildScrollView(
              scrollDirection: Axis.vertical, // Vertical scrolling
              padding: EdgeInsets.all(16.0),
              child: Text(
                _text,
                style: TextStyle(fontSize: 24.0), // Increase the font size
                softWrap: true, // Enable automatic text wrapping
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _toggleListening,
              child: _isListening ? Text('Stop Listening') : Text('Start Listening'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == stt.SpeechToText.listeningStatus) {
            setState(() {
              _isListening = true;
            });
          } else if (status == stt.SpeechToText.notListeningStatus) {
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (error) {
          print('Error: $error');
          setState(() {
            _isListening = false;
          });
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
          // Set listenFor to a longer duration (e.g., 30 minutes) to continuously listen
          listenFor: Duration(minutes: 30), // Adjust this as needed
        );
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  void dispose() {
    _speech.cancel();
    super.dispose();
  }
}