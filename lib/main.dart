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
    super.initState();
  }

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
  }

  final List<int> sharps = [25, 27, 0, 30, 32, 34, 0];
  final List<int> notes = [24, 26, 28, 29, 31, 33, 35, 36];

  @override
  Widget build(BuildContext context) {
    void playNote(int note) {
      MidiUtils.play(note);
      //if (feedback) {
      //   VibrateUtils.light();
      // }
    }

    /// Renders a single key to the screen
    Expanded renderKey(int note, bool sharp) {
      return Expanded(
        child: Container(
          width: 450,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FlatButton(
              height: 10.0,
              color: sharp ? Colors.black : Colors.white,
              textColor: sharp ? Colors.white : Colors.black,
              onPressed: () => playNote(note + (12 * 4)),
              child: Text(
                'note $note',
              ),
            ),
          ),
        ),
      );
    }

    Stack renderOctive() {
      return Stack(
        children: [
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
            right: 0.0,
            bottom: 0.0,
            top: 0.0,
            width: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                for (var i = 0; i < sharps.length; i++)
                  sharps[i] == 0
                      ? Container(
                          width: 150 * .5,
                          height: 150 * .5,
                        )
                      : renderKey(sharps[i], true)
              ],
            ),
          ),
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
