import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(PianoApp());

class PianoApp extends StatelessWidget {
  /// Initialise audio cache
  static AudioCache player = AudioCache();

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
  ];
  //E#

  @override
  Widget build(BuildContext context) {
    /// play a note depending on it's file name
    /// expects an integer as a parameter
    void playNote(String note) {
      player.play('$note.mp3');
    }

    // playNote();

    /// Renders a single key to the screen
    Expanded renderKey(String note, {bool sharp = false}) {
      var keyPadding = 2;

      if (note == 'E#')
        return Expanded(
          child: Text(''),
        );
      return Expanded(
        // child: Padding(
        // padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),

        child: Container(
          // margin: Margin.all,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FlatButton(
              color: sharp ? Colors.black : Colors.white,
              textColor: sharp ? Colors.white : Colors.black,
              onPressed: () => playNote(note),
              child: Text(
                '$note',
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
        // ),
        // ),
      );
    }

    Stack renderOctive() {
      List<String> sharps = [];
      List<String> keys = [];

      // notes.where((el) => el.contains('#'));

      for (var i = 0; i < notes.length; i++) {
        if (notes[i].contains('#')) {
          sharps.add(notes[i]);
        } else {
          keys.add(notes[i]);
        }
        // renderKey(i);
      }

      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < keys.length; i++) renderKey(keys[i]),
            ],
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < sharps.length; i++)
                  renderKey(sharps[i], sharp: true),
              ],
            ),
            right: 00.0,
            bottom: 50.0,
            top: 50.0,
            width: 200.0,
          ),
        ],
      );
      // Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: <Widget>[

      //   ],
      // );

      // keys.forEach((key) => renderKey(key))
    }

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
              color: Colors.black,
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: renderOctive()),
        ),
      ),
    );
  }
}
