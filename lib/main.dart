import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(PianoApp());

class PianoApp extends StatelessWidget {
  /// Initialise audio cache
  static AudioCache player = AudioCache();

  /// Create a list of colours
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple
  ];

  final List<String> notes = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'E#',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
    'B#',
  ];

  @override
  Widget build(BuildContext context) {
    /// play a note depending on it's file name
    /// expects an integer as a parameter
    void playNote(int note) {
      player.play('${notes[note]}.mp3');
    }

    // playNote();

    /// Renders a single key to the screen
    Widget renderKey(int i) {
      return Expanded(
        // child: GestureDetector(
        // onTap: () => print('press!'),
        child: OutlineButton(
          textColor: Colors.black,
          onPressed: () => playNote(i),
          child: Text('${notes[i]}'),
        ),
        // ),
      );
    }

    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (var i = 0; i < notes.length; i++) renderKey(i)
            ],
          ),
        ),
      )),
    );
  }
}
