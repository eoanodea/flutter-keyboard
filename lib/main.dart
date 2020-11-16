import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard/MidiUtils.dart';
import 'MidiUtils.dart';

void main() => runApp(PianoApp());

class PianoApp extends StatefulWidget {
  @override
  _PianoAppState createState() => _PianoAppState();
}

class _PianoAppState extends State<PianoApp> with WidgetsBindingObserver {
  @override
  initState() {
    _loadSoundFont();
    // _initNotes();
    super.initState();
  }

  /// Initialise audio cache
  // static AudioCache player = AudioCache();

  void _loadSoundFont() async {
    MidiUtils.unmute();
    print('loading');

    rootBundle.load("assets/Piano.sf2").then((sf2) {
      print('preparing piano + $sf2');
      MidiUtils.prepare(sf2, "Piano.sf2");
    });
    // VibrateUtils.canVibrate.then((vibrate) {
    //   if (mounted)
    //     setState(() {
    //       canVibrate = vibrate;
    //     });
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("State: $state");
    _loadSoundFont();
    // _initNotes();
  }

  // final List<String> notes = [
  //   'C',
  //   'C#',
  //   'D',
  //   'D#',
  //   'E',
  //   'E#',
  //   'F',
  //   'F#',
  //   'G',
  //   'G#',
  //   'A',
  //   'A#',
  //   'B',
  // ];

  final List<int> sharps = [25, 27, 0, 30, 32, 24];
  final List<int> notes = [24, 26, 28, 29, 31, 33, 35];

  // void _initNotes() {
  //   for (var i = 24; i < 36; i++) {
  //     notes.add(i);
  //   }

  //   print('notes! ${notes.length}');
  // }

  // final List<int> notes = [];

  @override
  Widget build(BuildContext context) {
    /// play a note depending on it's file name
    /// expects an integer as a parameter
    void playNote(int note) {
      // player.play('$note.mp3');
      MidiUtils.play(note);
      //       if (feedback) {
      //   VibrateUtils.light();
      // }
    }

    /// Renders a single key to the screen
    Expanded renderKey(int note, bool sharp) {
      return Expanded(
        // child: Padding(
        // padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),

        child: Container(
          width: 450,
          // margin: Margin.all,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FlatButton(
              color: sharp ? Colors.black : Colors.white,
              textColor: sharp ? Colors.white : Colors.black,
              onPressed: () => playNote(note),
              child: Text(
                'note $note',
              ),
            ),
          ),
        ),
      );
    }

    Stack renderOctive() {
      // List<String> sharps = [];
      // List<String> keys = [];

      // for (var i = 0; i < notes.length; i++) {
      //   // if (notes[i].contains('#')) {
      //     // sharps.add(notes[i]);
      //   // } else {
      //     // keys.add(notes[i]);
      //   }
      // }

      return Stack(
        children: [
          // Positioned(
          //   top: 0.0,
          //   bottom: 0.0,
          //   left: 0.0,
          //   width: 500.0,
          // child:
          Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < notes.length; i++)
                  renderKey(notes[i], false),
              ],
            ),
          ),
          // ),
          Positioned(
            // left: 0.0,
            // right: 0.0,
            // bottom: 100,
            // top: 0.0,
            // left: 0.0,
            right: 0.0,
            bottom: 0.0,
            top: 0.0,
            width: 200.0,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (var i = 0; i < sharps.length; i++)
                  sharps[i] == 0
                      ? Container(
                          width: 100 * .5,
                          height: 100 * .5,
                        )
                      : renderKey(sharps[i], true)
              ],
            ),
          ),
          // Positioned(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       for (var i = 0; i < sharps.length; i++)
          //         renderKey(sharps[i], sharp: true),
          //     ],
          //   ),
          // right: 00.0,
          // bottom: 50.0,
          // top: 50.0,
          // width: 200.0,
          // ),
        ],
      );
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: renderOctive(),
          ),
        ),
      ),
    );
  }
}
